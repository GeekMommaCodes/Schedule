//
//  PearViewControllerTodayViewController.h
//  Schedule
//
//  Created by Sven Bär on 10.06.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PearAppDelegate.h"
#import "PearTableViewControllerToday.h"


@interface PearViewControllerTodayNewEntry : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *LblSubject;
@property (strong, nonatomic) IBOutlet UITextField *TxtSubject;
@property (strong, nonatomic) IBOutlet UILabel *LblTeacher;
@property (strong, nonatomic) IBOutlet UITextField *TxtTeacher;
@property (strong, nonatomic) IBOutlet UILabel *LblRoom;
@property (strong, nonatomic) IBOutlet UITextField *TxtRoom;
@property (strong, nonatomic) IBOutlet UIPickerView *PckHour;
@property (strong, nonatomic) IBOutlet UIPickerView *PckDay;
@property (strong, nonatomic) IBOutlet UIPickerView *PckSchoolSubject;
@property (strong, nonatomic) IBOutlet UILabel *LblHour;
@property (strong, nonatomic) IBOutlet UITextField *TxtHour;
@property (strong, nonatomic) IBOutlet UILabel *LblDay;
@property (strong, nonatomic) IBOutlet UITextField *TxtDay;


@property bool dayFlag;
@property bool hourFlag;


- (IBAction)textFieldDoneEditing:(id)sender;

- (IBAction)saveEntry:(id)sender;
- (IBAction)cancelNewTodayEntry:(id)sender;
- (IBAction)weekDayEdit:(id)sender;
- (IBAction)hourEdit:(id)sender;
- (IBAction)schoolSubjectEdit:(id)sender;

- (BOOL) addNewTodayEntry;
@end
