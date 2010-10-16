    //
//  PSShareViewController.m
//  pinkelstar-iOS-Simple-UI
//
//  Created by Alexander van Elsas on 10/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <PinkelStar/PSPinkelStar.h>
#import <PinkelStar/PSPermissionView.h>
#import "PSShareViewController.h"
#import <QuartzCore/QuartzCore.h>

//static CGFloat permissionViewOffsetX = 20.0;
//static CGFloat permissionViewOffsetY = 26.0;

@implementation PSShareViewController

@synthesize shareButton = _shareButton;
@synthesize userMessage = _userMessage;
@synthesize customLabel = _customLabel;
@synthesize shareTitleLabel = _shareTitleLabel;
@synthesize appIcon		= _appIcon;
@synthesize bgImageView	= _bgImageView;
@synthesize networkName = _networkName;
@synthesize popoverController = _pController;

// start a dialogue to obtain permission to publish to a specific social network
- (void) getPermissionPS:(NSString *) networkName
{
	PSPermissionView *permView = [[[PSPermissionView alloc] initWithDelegate:self] autorelease];
	//permView.frame = CGRectMake(permissionViewOffsetX, permissionViewOffsetX+permissionViewOffsetY, self.view.frame.size.width - 2*permissionViewOffsetX, self.view.frame.size.height - (2*permissionViewOffsetX + permissionViewOffsetY));
	permView.frame = CGRectMake(0, 0, 300, 460);
	permView.networkName = networkName;
	permView.sessionKey = [PSPinkelStarServer sharedInstance].psSessionKey;
	[permView show];
}

// Make sure the keyboard disappears when the user is done typing.
-(IBAction)textFieldDoneEditing:(id)sender
{
	[sender resignFirstResponder];
}

// Make sure the keyboard disappears when the user is done typing.
-(IBAction)backgroundTap:(id)sender
{
	[sender resignFirstResponder];
}

-(void) roundedCornerShareButton
{
	// Setting the publish button to be rounded
	[[_shareButton layer] setCornerRadius:7.0f];
	[[_shareButton layer] setMasksToBounds:YES];
	[[_shareButton layer] setBorderWidth:1.0f];
	[[_shareButton layer] setBorderColor:[[UIColor colorWithRed:0.0823 green:0.1137 blue:0.1922 alpha:1.0] CGColor]];
}

-(void) roundedCornerGreyArea
{
	// Setting the publish button to be rounded
	[[_bgImageView layer] setCornerRadius:7.0f];
	[[_bgImageView layer] setMasksToBounds:YES];
	[[_bgImageView layer] setBorderWidth:1.0f];
	[[_bgImageView layer] setBorderColor:[[UIColor colorWithRed:0.0823 green:0.1137 blue:0.1922 alpha:1.0] CGColor]];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[_appIcon setImage:[[PSPinkelStarServer sharedInstance] getApplicationIcon]];
	_customLabel.text = [NSString stringWithFormat:@"I just downloaded the %@ app for the iPad", [[PSPinkelStarServer sharedInstance] getApplicationName]];
	[_shareButton setTitle:[NSString stringWithString:@"Share now"] forState:UIControlStateNormal];
	_shareTitleLabel.text = [NSString stringWithFormat:@"Share on %@", _networkName];
	[self roundedCornerShareButton];
	[self roundedCornerGreyArea];
}

-(IBAction) shareButtonPressed
{
	NSLog(@"Sharebutton pressed");
	if([[PSPinkelStarServer sharedInstance] canPublishPS:_networkName])
	{
		NSLog(@"publishing to : %@", _networkName);
		
		// Don't forget you can add a content url to the share if you want to
		[[PSPinkelStarServer sharedInstance] publishPS:_userMessage.text eventMessage:_customLabel.text contentUrl:nil networkList:[NSArray arrayWithObject:_networkName]];
		// just for testing purposes we remove the permission afterwards
		//[[PSPinkelStarServer sharedInstance] revokePermissionPS:_networkName];
		[_shareButton setTitle:[NSString stringWithFormat:@"Shared!"] forState:UIControlStateNormal];
		
	}
	else 
	{
		// Get permission first, then publish
		[self getPermissionPS:_networkName];
	}
	[_pController dismissPopoverAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

// PSPermissionViewDelegate
// Called when the dialog succeeds and is about to be dismissed.
- (void)psPermissionViewDialogDidSucceed:(PSPermissionView *)pView
{
	[[PSPinkelStarServer sharedInstance] storePermissionPS:pView.networkName];	
	[[PSPinkelStarServer sharedInstance] publishPS:_userMessage.text eventMessage:_customLabel.text contentUrl:nil networkList:[NSArray arrayWithObject:pView.networkName]];
	
	// just for testing purposes we remove the permission afterwards
	//[[PSPinkelStarServer sharedInstance] revokePermissionPS:pView.networkName];
}

// Called when the dialog is cancelled and is about to be dismissed.
- (void)psPermissionViewDialogDidCancel:(PSPermissionView *)pView
{
	DebugLog(@"Entering PSMainViewController:dialogDidCancel");
}

// Called when permission dialog failed to load due to an error.
- (void)dialog:(PSPermissionView *)dialog didFailWithError:(NSError*)error
{
	DebugLog(@"Entering PSMainViewController:didFailWithError");
	
}

@end
