//
//  pinkelstar_iOS_iPad_only_demoViewController.m
//  pinkelstar-iOS-iPad-only-demo
//
//  Created by Alexander van Elsas on 10/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

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
	return @"v.0.9.2.iPad";
	
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
	_actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose sharing option" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
	// This can fail to display anything if the PinkelStar server initialization is too slow.
	// This usually will not happen unless the user starts sharing immediately during app startup
	// We will update as soon as the server response is in.
	_actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
	[self updateActionSheet];
	
	//[_actionSheet showFromRect:rect inView:self.view animated:YES];
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
			// Note that you can start full blown multi-network sharing here by calling:
			// [self showPinkelStarFullInterface];
			NSLog(@"Start the share process here");
			[self shareViaSocialNetwork:networkName];
			//[self showPinkelStarFullInterface];
			
			
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

///////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// All delegation methods
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////

// PSPinkelStarServerDelegate

// Server not available. Be careful when using this. It can take up to
// 30 seconds to test if a server is availible or not.
// It is better to wait for psInternetNotAvailable to fire. It's a better indicator
-(void) psServerNotAvailable:(PSPinkelStarServer *) server
{
	NSLog(@"Server is not available");
	// Wouldn't use this lightly. It can take a while to detect if there is no server available
}

// This fires if we do not detect Internet on the phone
-(void) psInternetNotAvailable:(PSPinkelStarServer *) server
{
	NSLog(@"Internet is not available");
}

// This fires if we do detect Internet on the phone (again)
-(void) psInternetAvailable:(PSPinkelStarServer *) server
{
	NSLog(@"Internet is available now");
}

-(void) psInvalidApplicationKeySecret:(PSPinkelStarServer *) server
{
	// If you forget to enter your application key and secret in the
	// pinkelstar.plist file this method will
	// fire
	NSLog(@"Please update your pinkelstar.plist file with your app key and secret");
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
