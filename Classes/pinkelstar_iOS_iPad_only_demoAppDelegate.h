//
//  pinkelstar_iOS_iPad_only_demoAppDelegate.h
//  pinkelstar-iOS-iPad-only-demo
//
//  Created by Alexander van Elsas on 10/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PinkelStar/PSPinkelStar.h>

@class pinkelstar_iOS_iPad_only_demoViewController;

@interface pinkelstar_iOS_iPad_only_demoAppDelegate : NSObject 
<UIApplicationDelegate, PSShareButtonDelegate> {
    UIWindow *window;
    pinkelstar_iOS_iPad_only_demoViewController *_viewController;
	PSPinkelStarServer *_sharedPSServer;
	UIPopoverController *_popController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet pinkelstar_iOS_iPad_only_demoViewController *viewController;
@property (nonatomic, retain) IBOutlet UIPopoverController *popController;

@end

