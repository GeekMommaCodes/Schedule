//
//  PearViewControllerToDoDetail.h
//  Schedule
//
//  Created by Sven Bär on 10.05.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PearEntryToDo.h"
#import "PearAppDelegate.h"

@interface PearViewControllerToDoDetail : UIViewController


@property (strong, nonatomic) IBOutlet UILabel *schoolSubject;
@property (strong, nonatomic) IBOutlet UILabel *due;
@property (strong, nonatomic) IBOutlet UILabel *subject;
@property (strong, nonatomic) IBOutlet UILabel *note;

@property (strong, nonatomic) IBOutlet UITextField *schoolSubjectTxtBox;
@property (strong, nonatomic) IBOutlet UITextField *dueDateTxtBox;
@property (strong, nonatomic) IBOutlet UITextField *subjectTxtBox;
@property (strong, nonatomic) IBOutlet UITextField *noteTxtBox;
@property (strong, nonatomic) IBOutlet UIDatePicker *PckDate;
@property (strong, nonatomic) IBOutlet UIPickerView *PckSchoolSubjekt;

@property bool subjectFlag;

@property PearEntryToDo * pearEntryToDo;
@property NSIndexPath * currentIndex;

- (IBAction)cancelToDoDetail:(id)sender;
- (IBAction)saveToDoDetail:(id)sender;
- (IBAction)dateValueChanged:(id)sender;

- (IBAction)textFieldDoneEditing:(id)sender;

- (void) updateData;
- (void) saveChangedData;
- (void) setDueDate:(NSDate*)newDate;
- (IBAction)schoolSubjectEdit:(id)sender;
- (IBAction)schoolSubjectEditEnd:(id)sender;
- (void) setPickerDate:(NSString *)dueDate;
- (void) setCurrentItem:(PearEntryToDo *)newEntry index:(NSIndexPath *) ind;
@end
