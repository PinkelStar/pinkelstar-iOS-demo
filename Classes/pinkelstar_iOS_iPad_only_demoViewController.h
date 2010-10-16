//
//  pinkelstar_iOS_iPad_only_demoViewController.h
//  pinkelstar-iOS-iPad-only-demo
//
//  Created by Alexander van Elsas on 10/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PinkelStar/PSPinkelStar.h>

@interface pinkelstar_iOS_iPad_only_demoViewController : UIViewController
<UIActionSheetDelegate, PSMailViewControllerDelegate, PSMainViewControllerDelegate, PSPinkelStarServerDelegate>
{
	UIActionSheet *_actionSheet;
	UIPopoverController *_popController;
	CGRect _popoverRect;
		
}
@property(nonatomic, retain) UIActionSheet *actionSheet;
@property(nonatomic, retain) UIPopoverController *popController;
	
// Current version of the iPad UI code
+ (NSString *) version;

-(void) openSharePopover:(CGRect) rect;
	
@end

