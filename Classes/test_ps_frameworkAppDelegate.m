//
//  test_ps_frameworkAppDelegate.m
//  test_ps_framework
//
//  Created by Alexander van Elsas on 5/26/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "test_ps_frameworkAppDelegate.h"
#import "SimpleRotationUIViewController.h"

@implementation test_ps_frameworkAppDelegate

@synthesize window;
@synthesize rootController;
@synthesize psMainViewController;
@synthesize psServerSharedInstance;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
	// Make sure that the ROOT ViewController is capable of rotating in all directions
	rootController = [[SimpleRotationUIViewController alloc] init];
	
	// We initialize the server at program launch. This enables the server to send us all relevant data
	// to set up the PinkelStar sharing process
	psServerSharedInstance = [PSPinkelStarServer sharedInstance];

	
	// Display all types of buttons here.
	// Normally we would obviously choose only one :-)
	
	//SMALL
	PSShareButton *shareButton1 = [[[PSShareButton alloc] init] autorelease];
	shareButton1.style = PSShareButtonStyleSmallGrey;
	shareButton1.delegate = self;
	[shareButton1 setButtonPosition:CGPointMake(35,70)];
	
	PSShareButton *shareButton2 = [[[PSShareButton alloc] init] autorelease];
	shareButton2.style = PSShareButtonStyleSmallBlack;
	shareButton2.delegate = self;
	[shareButton2 setButtonPosition:CGPointMake(170,70)];
	
	PSShareButton *shareButton3 = [[[PSShareButton alloc] init] autorelease];
	shareButton3.style = PSShareButtonStyleSmallPink;
	shareButton3.delegate = self;
	[shareButton3 setButtonPosition:CGPointMake(35,110)];
	
	PSShareButton *shareButton4 = [[[PSShareButton alloc] init] autorelease];
	shareButton4.style = PSShareButtonStyleSmallPinkShine;
	shareButton4.delegate = self;
	[shareButton4 setButtonPosition:CGPointMake(170,110)];
	
	//MEDIUM
	PSShareButton *shareButton5 = [[[PSShareButton alloc] init] autorelease];
	shareButton5.style = PSShareButtonStyleMediumGrey;
	shareButton5.delegate = self;
	[shareButton5 setButtonPosition:CGPointMake(35,150)];
	
	PSShareButton *shareButton6 = [[[PSShareButton alloc] init] autorelease];
	shareButton6.style = PSShareButtonStyleMediumBlack;
	shareButton6.delegate = self;
	[shareButton6 setButtonPosition:CGPointMake(170,150)];
	
	PSShareButton *shareButton7 = [[[PSShareButton alloc] init] autorelease];
	shareButton7.style = PSShareButtonStyleMediumPink;
	shareButton7.delegate = self;
	[shareButton7 setButtonPosition:CGPointMake(35,210)];
	
	PSShareButton *shareButton8 = [[[PSShareButton alloc] init] autorelease];
	shareButton8.style = PSShareButtonStyleMediumPinkShine;
	shareButton8.delegate = self;
	[shareButton8 setButtonPosition:CGPointMake(170,210)];
	
	//LARGE
	PSShareButton *shareButton9 = [[[PSShareButton alloc] init] autorelease];
	shareButton9.style = PSShareButtonStyleLargeBlack;
	shareButton9.delegate = self;
	[shareButton9 setButtonPosition:CGPointMake(35,270)];
	
	PSShareButton *shareButton10 = [[[PSShareButton alloc] init] autorelease];
	shareButton10.style = PSShareButtonStyleLargeGrey;
	shareButton10.delegate = self;
	[shareButton10 setButtonPosition:CGPointMake(35,310)];
	
	PSShareButton *shareButton11 = [[[PSShareButton alloc] init] autorelease];
	shareButton11.style = PSShareButtonStyleLargePink;
	shareButton11.delegate = self;
	[shareButton11 setButtonPosition:CGPointMake(35,350)];
	
	PSShareButton *shareButton12 = [[[PSShareButton alloc] init] autorelease];
	shareButton12.style = PSShareButtonStyleLargePinkShine;
	shareButton12.delegate = self;
	[shareButton12 setButtonPosition:CGPointMake(35,390)];
	
	
	// test a custom button here
	PSShareButton *shareButton13 = [[[PSShareButton alloc] init] autorelease];
	shareButton13.style = PSShareButtonStyleCustom;
	//shareButton13.buttonTitle.text = @"Cool";
	shareButton13.buttonTitle.frame = CGRectMake(10, 10, 50, 20);
	[shareButton13 setCustomButtonImageName:[NSString stringWithFormat:@"custom_image.png"]];
	[shareButton13 setCustomButtonHighlightedImageName:[NSString stringWithFormat:@"custom_image_highlighted.png"]];
	shareButton13.delegate = self;
	[shareButton13 setButtonPosition:CGPointMake(250,330)];
	[shareButton13 usePinkelStarIcon:NO];
	
	//new LIKE buttons
	PSShareButton *shareButton14 = [[[PSShareButton alloc] init] autorelease];
	shareButton14.style = PSLikeButtonStyleSmallPink;
	shareButton14.delegate = self;
	[shareButton14 setButtonPosition:CGPointMake(35,30)];
	
	PSShareButton *shareButton15 = [[[PSShareButton alloc] init] autorelease];
	shareButton15.style = PSLikeButtonStyleSmallBlack;
	shareButton15.delegate = self;
	[shareButton15 setButtonPosition:CGPointMake(100,30)];
	
	PSShareButton *shareButton16 = [[[PSShareButton alloc] init] autorelease];
	shareButton16.style = PSLikeButtonStyleSmallGrey;
	shareButton16.delegate = self;
	[shareButton16 setButtonPosition:CGPointMake(170,30)];
	
	PSShareButton *shareButton17 = [[[PSShareButton alloc] init] autorelease];
	shareButton17.style = PSLikeButtonStyleSmallPinkShine;
	shareButton17.delegate = self;
	[shareButton17 setButtonPosition:CGPointMake(240,30)];
	
	[rootController.view addSubview:shareButton1];
	[rootController.view addSubview:shareButton2];
	[rootController.view addSubview:shareButton3];
	[rootController.view addSubview:shareButton4];
	[rootController.view addSubview:shareButton5];
	[rootController.view addSubview:shareButton6];
	[rootController.view addSubview:shareButton7];
	[rootController.view addSubview:shareButton8];
	[rootController.view addSubview:shareButton9];
	[rootController.view addSubview:shareButton10];
	[rootController.view addSubview:shareButton11];
	[rootController.view addSubview:shareButton12];
	[rootController.view addSubview:shareButton13];
	[rootController.view addSubview:shareButton14];
	[rootController.view addSubview:shareButton15];
	[rootController.view addSubview:shareButton16];
	[rootController.view addSubview:shareButton17];
	
    // Override point for customization after app launch 
    [window addSubview:rootController.view];
    [window makeKeyAndVisible];
}

// PSShareButtonDelegate
- (void)psSharebutonPressed:(PSShareButton *)shareButton;
{
	// The PSMainViewController clas defaults to an installation event <user> has just downloaded <your_app_name>
	//
	// There are several possibilites for customization, please take a look at the PSMainViewController.h file for details
	// e.g.
	// Set a specific content url that appears in the share message using
	// [psMainViewController addContentUrl:<a content url>];
	//
	// Change the share message type and content
	// [psMainViewController setPSEventType:PSCustomEvent];
	// [psMainViewController addCustomShareMessage:<a different share message>;
	// Etc.
	
	// Set up the main PinkelStar Viewcontroller
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		DebugLog(@"Opening the iPad nib file now");
		psMainViewController = [[PSMainViewController alloc] initWithNibName:@"PSMainViewController_iPad" bundle:nil];
		psMainViewController.modalPresentationStyle = UIModalPresentationFormSheet;
		psMainViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	} 
	else 
	{
		psMainViewController = [[PSMainViewController alloc] initWithNibName:@"PSMainViewController_iPhone" bundle:nil];
		psMainViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
		
	}
	psMainViewController.delegate = self;
	
	[psMainViewController setEventType:PSInstallationEvent];
	
	[rootController presentModalViewController:psMainViewController animated:YES];
}

// Called as soon as the pinkestar process is finished
- (void)psFinished:(PSMainViewController *)vController
{
	[rootController dismissModalViewControllerAnimated:YES];
	
}

- (void)dealloc {
    [rootController release];
	[psServerSharedInstance release];
    [window release];
    [super dealloc];
}


@end
