//
//  PearViewControllerTodayDetailViewController.h
//  Schedule
//
//  Thi controller handles editing today entries in detail.
//
//  Created by Markus Kosmal on 05.09.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PearEntryToday.h"
#import "../PearAppDelegate.h"

@interface PearViewControllerTodayDetailViewController : UIViewController

//hold an instance of pearAppDelegate
@property PearAppDelegate * pearAppDelegate;

//labels for signing the display content
@property (weak, nonatomic) IBOutlet UILabel *labelTeacher;
@property (weak, nonatomic) IBOutlet UILabel *labelSubject;
@property (weak, nonatomic) IBOutlet UILabel *labelRoom;
@property (weak, nonatomic) IBOutlet UILabel *labelHour;
@property (weak, nonatomic) IBOutlet UILabel *labelDay;

//textBoxes for content
@property (weak, nonatomic) IBOutlet UITextField *textBoxSubject;
@property (weak, nonatomic) IBOutlet UITextField *textBoxTeacher;
@property (weak, nonatomic) IBOutlet UITextField *textBoxRoom;
@property (weak, nonatomic) IBOutlet UITextField *textBoxHour;
@property (weak, nonatomic) IBOutlet UITextField *textBoxDay;

//the pickers for filling the relevant text fields
@property (weak, nonatomic) IBOutlet UIPickerView *pickerSubject;
@property (weak, nonatomic) IBOutlet UIDatePicker *pickerDay;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerHour;

//currently selected item data
@property PearEntryToday * currentPearEntryToday;
@property NSIndexPath * currentIndexPath;

//methods for saving and canceling the editing process
- (IBAction)cancelEditing:(id)sender;
- (IBAction)saveEditing:(id)sender;

//methods for updating data when current item is selected in parent view
-(void) updateData;
-(void) setCurrentItem: (PearEntryToday *)newEntry index:(NSIndexPath *) ind;

@end
