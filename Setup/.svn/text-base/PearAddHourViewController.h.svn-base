//
//  PearAddHourViewController.h
//  Schedule
//
//  Created by Sven Bär on 10.06.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PearAppDelegate.h"

@interface PearAddHourViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *LblStartTime;
@property (strong, nonatomic) IBOutlet UILabel *LblEndTime;
@property (strong, nonatomic) IBOutlet UILabel *LblIsPause;
@property (strong, nonatomic) IBOutlet UITextField *TxtStartTime;
@property (strong, nonatomic) IBOutlet UITextField *TxtEndTime;
@property (strong, nonatomic) IBOutlet UISwitch *SwIsPause;
@property (strong, nonatomic) IBOutlet UIDatePicker *PckTime;
@property bool startFlag;

- (IBAction)startDateEdit:(id)sender;
- (IBAction)endDateEdit:(id)sender;

- (IBAction)saveHour:(id)sender;
- (IBAction)cancelNewHourEntry:(id)sender;
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)datePickerValueChanged:(id)sender;
- (void)clearHourValues;
- (void)setDateFromDatePicker:(NSDate*)inDate;
@end
