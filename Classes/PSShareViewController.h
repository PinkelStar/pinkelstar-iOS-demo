//
//  PSShareViewController.h
//  pinkelstar-iOS-Simple-UI
//
//  Created by Alexander van Elsas on 10/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSShareViewController : UIViewController
{
	// UI stuff
	UIButton *_shareButton;
	UITextField *_userMessage;
	UILabel *_customLabel;
	UILabel *_shareTitleLabel;
	UIImageView *_appIcon;
	UIImageView *_bgImageView;
	
	NSString *_networkName;
	// Keep a pointer to the popover so that it can be dismissed
	UIPopoverController *_pController;
}

// UI
@property(nonatomic, retain) IBOutlet UIButton *shareButton;
@property(nonatomic, retain) IBOutlet UITextField *userMessage;
@property(nonatomic, retain) IBOutlet UILabel *customLabel;
@property(nonatomic, retain) IBOutlet UILabel *shareTitleLabel;
@property(nonatomic, retain) IBOutlet UIImageView *appIcon;
@property(nonatomic, retain) IBOutlet UIImageView *bgImageView;

@property(nonatomic, retain) NSString *networkName;
@property(nonatomic, retain) UIPopoverController *popoverController;

-(IBAction) shareButtonPressed;
@end
