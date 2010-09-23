//
//  test_ps_frameworkAppDelegate.h
//  test_ps_framework
//
//  Created by Alexander van Elsas on 5/26/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PinkelStar/PSPinkelStar.h>

@class PSMainViewController;
@class PSPinkelStarServer;
@class SimpleRotationUIViewController;

@interface test_ps_frameworkAppDelegate : NSObject 
<UIApplicationDelegate, PSShareButtonDelegate, PSMainViewControllerDelegate> {
    UIWindow *window;
    SimpleRotationUIViewController *rootController;
	PSMainViewController *psMainViewController;
	PSPinkelStarServer *psServerSharedInstance;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SimpleRotationUIViewController *rootController;
@property (nonatomic, retain) IBOutlet PSMainViewController *psMainViewController;
@property (nonatomic, retain) PSPinkelStarServer *psServerSharedInstance;

@end

