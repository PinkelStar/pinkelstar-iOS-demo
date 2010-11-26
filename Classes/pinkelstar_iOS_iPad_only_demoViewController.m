//
//  pinkelstar_iOS_iPad_only_demoViewController.m
//  pinkelstar-iOS-iPad-only-demo
//
//  Created by Alexander van Elsas on 10/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


// Please note that this demo only shows a simple native iPad UI that handles
// sharing. It isn't produciton quality as it lacks error handling
// Use it for inspiration only. In the main branch of the pinkelstar-iOS-demo-app
// repository you will find a full fledged demo app 

#import "pinkelstar_iOS_iPad_only_demoViewController.h"
#import "PSShareViewController.h"

static float actionSheetWidth = 272.0;
static float actionSheetHeight = 230.0;

@implementation pinkelstar_iOS_iPad_only_demoViewController
@synthesize actionSheet = _actionSheet;
@synthesize popController = _popController;

// Current version of the iPad UI code
+ (NSString *) version
{
	return @"v.0.9.3.iPad";
	
}

-(void) shareViaEmail
{
	PSMailViewController *mailController = [[[PSMailViewController alloc] init] autorelease];
	mailController.psMailDelegate = self;
	mailController.subj = @"E-mail sharing is pretty cool";
	mailController.body = @"This is a test to show e-mail sharing. You can set the body text to anything you want. You can also add a url or image to the e-mail";
	// If you want your user to share an image, or other types of data try this for example:
	// mailcontroller.image = [UIImage imageNamed:@"Whatever_image.png"];
	// see the PSMailViewController.h file for more email share options
	
	mailController.urlString  = @"http://www.pinkelstar.com/";
	
	mailController.image = [UIImage imageNamed:@"email@2x.png"];
	
	mailController.appName = @"the PinkelStar Test Application";
	[mailController setupMailView];
	[self presentModalViewController:mailController animated:YES];
}

// Only use this if you want your users to share on multiple networks simultanously
-(void) showPinkelStarFullInterface
{
	// lets make this a popover interface now	
	PSMainViewController *psController = [[PSMainViewController alloc] initWithNibName:[NSString stringWithString:@"PSMainViewController_iPad"] bundle:nil];
	psController.psMainDelegate = self;
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:psController];
	psController.contentSizeForViewInPopover = CGSizeMake(540, 578);
	
	UIPopoverController *pController = [[UIPopoverController alloc] initWithContentViewController:navController];
	[psController release];
	[navController release];
	self.popController = pController;
	[pController release];
	
	//Now see if we can show the popup
	[pController presentPopoverFromRect:_popoverRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

// Call this for sharing to a single network
-(void) shareViaSocialNetwork:(NSString *) networkName
{
	PSShareViewController *shareController = [[[PSShareViewController alloc] init] autorelease];
	shareController.networkName = networkName;
	// You can set the share popover to use a custom image URL instead of your app icon
	// Try this, uncomment the following line if needed
	shareController.customImageURL = [NSURL URLWithString:@"http://www.factor-software.com/images/boom_icon_huge.png"];
	
	// we make it intentionally as big as the action sheet. It prevents iOS from flipping the popover
	// to another position
	shareController.contentSizeForViewInPopover = CGSizeMake(actionSheetWidth, actionSheetHeight);
	UIPopoverController *pController = [[UIPopoverController alloc] initWithContentViewController:shareController];
	shareController.popoverController = pController;
	
	[pController presentPopoverFromRect:_popoverRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
	[pController release];
}

-(void) psFinished:(PSMainViewController *)vController
{
	[_popController dismissPopoverAnimated:YES];
}

-(void) updateActionSheet
{
	for(int i=0;i<[[[PSPinkelStarServer sharedInstance] getSupportedSocialNetworks] count]; i++)
		[_actionSheet addButtonWithTitle:[[[PSPinkelStarServer sharedInstance] getSupportedSocialNetworks] objectAtIndex:i]];
	[_actionSheet showFromRect:_popoverRect inView:self.view animated:NO];
}

-(void) openSharePopover:(CGRect) rect
{
	_popoverRect = rect; // save this to position the popover correctly later
	
	// If you really want to you could show the full interface in the popover too
	// If so, uncomment the next line and comment out anything else below that
	//[self showPinkelStarFullInterface];
	
	// Comment out everything below here if you want to see the full UI in the popover
	_actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose sharing option" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
	// This can fail to display anything if the PinkelStar server initialization is too slow.
	// This usually will not happen unless the user starts sharing immediately during app startup
	// We will update as soon as the server response is in.
	_actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
	[self updateActionSheet];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex != -1)
	{
		// See what button was clicked and act accordingly
		NSString *networkName = [[[PSPinkelStarServer sharedInstance] getSupportedSocialNetworks] objectAtIndex:buttonIndex];
		NSLog(@"The user choose to share to: %@", networkName);
		if([networkName isEqual:@"email"])
			[self shareViaEmail];
		else
		{
			NSLog(@"Start the share process here");
			[self shareViaSocialNetwork:networkName];
		}
	}
	else
		NSLog(@"Just dismiss it");	
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[_actionSheet release];
	if(_popController)
		[_popController release];
    [super dealloc];
}

// PSPinkelStar server delegate
-(void) psInitFinished:(PSPinkelStarServer *) server
{
	NSLog(@"Server init response is in. Calling update ActionSheet.");
	// The server has initialized, now update the action sheet
	[_actionSheet dismissWithClickedButtonIndex:0 animated:NO];
	[self updateActionSheet];
}

@end
