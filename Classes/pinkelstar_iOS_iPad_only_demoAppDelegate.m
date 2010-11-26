//
//  pinkelstar_iOS_iPad_only_demoAppDelegate.m
//  pinkelstar-iOS-iPad-only-demo
//
//  Created by Alexander van Elsas on 10/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "pinkelstar_iOS_iPad_only_demoAppDelegate.h"
#import "pinkelstar_iOS_iPad_only_demoViewController.h"

@implementation pinkelstar_iOS_iPad_only_demoAppDelegate

@synthesize window;
@synthesize viewController = _viewController, popController = _popController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	// Init PinkelStar
	[PSPinkelStarServer sharedInstance];
	// Create a viewController
	_viewController = [[pinkelstar_iOS_iPad_only_demoViewController alloc] init];
	
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
	
	// LIKE buttons
	PSShareButton *shareButton14 = [[[PSShareButton alloc] init] autorelease];
	shareButton14.style = PSLikeButtonStyleSmallPink;
	shareButton14.delegate = self;
	[shareButton14 setButtonPosition:CGPointMake(35,30)];
	
	PSShareButton *shareButton15 = [[[PSShareButton alloc] init] autorelease];
	shareButton15.style = PSLikeButtonStyleSmallBlack;
	shareButton15.delegate = self;
	[shareButton15 setButtonPosition:CGPointMake(35,700)];
	
	PSShareButton *shareButton16 = [[[PSShareButton alloc] init] autorelease];
	shareButton16.style = PSLikeButtonStyleSmallGrey;
	shareButton16.delegate = self;
	[shareButton16 setButtonPosition:CGPointMake(700,700)];
	
	PSShareButton *shareButton17 = [[[PSShareButton alloc] init] autorelease];
	shareButton17.style = PSLikeButtonStyleSmallPinkShine;
	shareButton17.delegate = self;
	[shareButton17 setButtonPosition:CGPointMake(700,30)];
	
	[_viewController.view addSubview:shareButton1];
	[_viewController.view addSubview:shareButton2];
	[_viewController.view addSubview:shareButton3];
	[_viewController.view addSubview:shareButton4];
	[_viewController.view addSubview:shareButton5];
	[_viewController.view addSubview:shareButton6];
	[_viewController.view addSubview:shareButton7];
	[_viewController.view addSubview:shareButton8];
	[_viewController.view addSubview:shareButton9];
	[_viewController.view addSubview:shareButton10];
	[_viewController.view addSubview:shareButton11];
	[_viewController.view addSubview:shareButton12];
	[_viewController.view addSubview:shareButton14];
	[_viewController.view addSubview:shareButton15];
	[_viewController.view addSubview:shareButton16];
	[_viewController.view addSubview:shareButton17];
	
	[window addSubview:_viewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}

-(void) psSharebutonPressed:(PSShareButton *) sender
{
	[_viewController openSharePopover:sender.frame];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [_viewController release];
    [window release];
    [super dealloc];
}


@end
