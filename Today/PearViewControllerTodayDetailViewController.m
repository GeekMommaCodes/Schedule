//
//  PearViewControllerTodayDetailViewController.m
//  Schedule
//
//  Created by Markus Kosmal on 05.09.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import "PearViewControllerTodayDetailViewController.h"

@interface PearViewControllerTodayDetailViewController ()

@end

@implementation PearViewControllerTodayDetailViewController

//synthesize ui pickers
@synthesize pickerDay, pickerSubject, pickerHour;

//synthesize ui labels
@synthesize labelDay, labelHour, labelRoom, labelSubject, labelTeacher;

//synthesize ui textBoxes
@synthesize textBoxDay, textBoxHour, textBoxRoom, textBoxSubject, textBoxTeacher;

//synthesize current items
@synthesize currentIndexPath, currentPearEntryToday;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.pearAppDelegate =  [UIApplication sharedApplication].delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self.pearAppDelegate updateScholSubjectPicker];
    [self.pearAppDelegate updateHourPicker];
    [self.pearAppDelegate updateDayPicker];
    [self doLoad];
}

- (void)viewDidUnload
{
    [self setLabelRoom:nil];
    [self setLabelTeacher:nil];
    [self setLabelSubject:nil];
    [self setLabelRoom:nil];
    [self setLabelHour:nil];
    [self setLabelDay:nil];
    [self setPickerDay:nil];
    [self setPickerSubject:nil];
    [self setPickerSubject:nil];
    [self setPickerDay:nil];
    [self setTextBoxSubject:nil];
    [self setTextBoxTeacher:nil];
    [self setTextBoxRoom:nil];
    [self setTextBoxHour:nil];
    [self setTextBoxDay:nil];
    [self setPickerHour:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

//do load data and fill
-(void) doLoad{
    [self initSubject];
    [self initHour];
}

//init labels
-(void) initLabels{
    labelSubject.text = NSLocalizedString(@"SchoolSubject.label",@"");
    labelTeacher.text = NSLocalizedString(@"Teacher.label",@"");
    labelHour.text = NSLocalizedString(@"Hour.label",@"");
    labelRoom.text = NSLocalizedString(@"Room.label",@"");
    labelDay.text = NSLocalizedString(@"Weekday.label",@"");
}

//init the subject picker
-(void) initSubject{
    if([self.pearAppDelegate.schoolSubjectCollectioon objectAtIndex:0] != nil){
        PearSchoolSubject * pearSchoolSubject =  [self.pearAppDelegate.schoolSubjectCollectioon objectAtIndex:0];
        self.textBoxSubject.text = [NSString stringWithFormat:@"%@ ",pearSchoolSubject.desc];
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert.Save.label",@"") message:NSLocalizedString(@"Alert.AddSchoolSubject.text",@"") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

}

//init the hour picker
-(void) initHour{
    if([self.pearAppDelegate.hourCollection objectAtIndex:0] != nil){
        PearSchoolHour * pearSchoolHour =  [self.pearAppDelegate.hourCollection objectAtIndex:0];
        if (pearSchoolHour.isPause == 0){
            textBoxHour.text = [NSString stringWithFormat:@"%@ - %@", pearSchoolHour.startingTime, pearSchoolHour.endingTime];
        }else {
            textBoxHour.text = [NSString stringWithFormat:@"%@ - %@ (Pause)", pearSchoolHour.startingTime, pearSchoolHour.endingTime];
        }
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert.Save.label",@"") message:NSLocalizedString(@"Alert.AddSchoolHour.text",@"") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

}

-(void) initPickerTextBoxContent{
    
    PearWeekDay * pearWeekDay = [self.pearAppDelegate.dayCollection objectAtIndex:0];
    textBoxDay.text = [NSString stringWithFormat:@"%@",pearWeekDay.WeekDay];
    
    UIView * dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    textBoxDay.inputView = dummyView;
    textBoxHour.inputView = dummyView;
    textBoxSubject.inputView = dummyView;
    
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:
(NSIndexPath *)indexPath {
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancelEditing:(id)sender {
}

- (IBAction)saveEditing:(id)sender {
}

-(void) updateData{
    
}
-(void) setCurrentItem: (PearEntryToday *)newEntry index:(NSIndexPath *) ind{
    
}

@end
