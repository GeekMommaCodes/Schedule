//
//  PearViewController.h
//  Schedule
//
//  Created by Sven Bär on 22.03.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Controller/PearDataModelController.h"
#import "PearMailController.h"

#import <MessageUI/MessageUI.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface PearViewControllerSetup : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *nameSync;
@property (strong, nonatomic) IBOutlet UILabel *nameSixDays;
@property (strong, nonatomic) IBOutlet UILabel *nameBadge;

@property (strong, nonatomic) IBOutlet UILabel *nameAddButton;
@property (strong, nonatomic) IBOutlet UILabel *nameAddSubject;

@property (strong, nonatomic) IBOutlet UISwitch *switchSync;
@property (strong, nonatomic) IBOutlet UISwitch *switchSixDays;
@property (strong, nonatomic) IBOutlet UISwitch *switchBadge;


@property (strong, nonatomic) IBOutlet UIButton *BtnAddHour;


-(void)initSetupData;
-(void)saveSetupData:(bool) errors;

-(IBAction)sendSupportMail:(id)sender;
-(IBAction)toggleEnabledForSwitchSync:(id)sender;
-(IBAction)toggleEnabledForSwitchSixDays:(id)sender;
-(IBAction)toggleEnabledForSwitchBadge:(id)sender;
-(IBAction)addButtonClicked:(id)sender;

-(IBAction)launchFeedback;
@end
