//
//  PearViewControllerToDoNewEntry.h
//  Schedule
//
//  Created by Sven Bär on 03.05.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PearAppDelegate.h"
#import "PearTableViewControllerToDo.h"

@interface PearViewControllerToDoNewEntry : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *schoolSubject;
@property (strong, nonatomic) IBOutlet UILabel *due;
@property (strong, nonatomic) IBOutlet UILabel *subject;
@property (strong, nonatomic) IBOutlet UILabel *note;

@property (strong, nonatomic) IBOutlet UITextField *schoolSubjectTxtBox;
@property (strong, nonatomic) IBOutlet UITextField *dueTxtBox;
@property (strong, nonatomic) IBOutlet UITextField *subjectTxtBox;
@property (strong, nonatomic) IBOutlet UITextField *noteTxtBox;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIPickerView *subjectPicker;

@property bool subjectFlag;

- (IBAction)textFieldDoneEditing:(id)sender;

- (IBAction)saveEntry:(id)sender;
- (IBAction)datePickerChanged:(id)sender;
- (IBAction)cancelNewToDoEntry:(id)sender;

- (IBAction)schoolSubjectEdit:(id)sender;
- (IBAction)schoolSubjectEditEnd:(id)sender;

-(BOOL)addNewToDoEntry;
-(void)setDueDate:(NSDate*)newDate;


@end
