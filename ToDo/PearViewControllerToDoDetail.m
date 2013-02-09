//
//  PearViewControllerToDoDetail.m
//  Schedule
//
//  Created by Sven Bär on 10.05.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import "PearViewControllerToDoDetail.h"

@interface PearViewControllerToDoDetail ()

@end

@implementation PearViewControllerToDoDetail
@synthesize schoolSubject;
@synthesize due;
@synthesize subject;
@synthesize note;
@synthesize schoolSubjectTxtBox;
@synthesize dueDateTxtBox;
@synthesize subjectTxtBox;
@synthesize noteTxtBox;
@synthesize PckDate;
@synthesize PckSchoolSubjekt;

@synthesize subjectFlag;


@synthesize pearEntryToDo, currentIndex;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
    [pearAppDelegate updateScholSubjectPicker];
	// Do any additional setup after loading the view.
    self.schoolSubject.text = NSLocalizedString(@"SchoolSubject.label",@"");
    self.due.text = NSLocalizedString(@"Due.label",@"");
    self.subject.text = NSLocalizedString(@"Subject.label",@"");
    self.note.text = NSLocalizedString(@"Note.label", @"");
    
    UIView * dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    schoolSubjectTxtBox.inputView = dummyView;
    
    

    NSLog(@"Detail view did load");
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setSchoolSubject:nil];
    [self setDue:nil];
    [self setSubject:nil];
    [self setNote:nil];


    [self setDueDateTxtBox:nil];
    [self setSchoolSubjectTxtBox:nil];
    [self setSubjectTxtBox:nil];
    [self setNoteTxtBox:nil];
    [self setPckDate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void) updateData
{
    if(pearEntryToDo != nil){
        self.subjectTxtBox.text = pearEntryToDo.subject;
        self.schoolSubjectTxtBox.text = pearEntryToDo.schoolSubject;
        self.noteTxtBox.text = pearEntryToDo.note;
        self.dueDateTxtBox.text = pearEntryToDo.dueDate;
        
        [self setPickerDate:pearEntryToDo.dueDate];
        NSLog(@"updateData works with data %@, %@, %@",pearEntryToDo.subject, pearEntryToDo.schoolSubject, pearEntryToDo.note );
    }
}

-(void) viewWillAppear:(BOOL)animated{
    [self updateData];
    [super viewWillAppear:animated];
}

-(void) viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;

    return pearAppDelegate.schoolSubjectCollectioon.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
    NSString * title;
    PearSchoolSubject * pearSchoolSubject = [pearAppDelegate.schoolSubjectCollectioon objectAtIndex:row];
    
    title = [NSString stringWithFormat:@"%@", pearSchoolSubject.desc];
    return title;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
    PearSchoolSubject * pearSchoolSubject = [pearAppDelegate.schoolSubjectCollectioon objectAtIndex:row];
    schoolSubjectTxtBox.text = [NSString stringWithFormat:@"%@", pearSchoolSubject.desc];
}

-(void)saveChangedData{
    PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext * context = pearAppDelegate.managedObjectContext;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Homework" inManagedObjectContext:context];
    [request setEntity:entity];
    NSError * error = nil;

    NSError * errorNew = nil;
    NSManagedObject * changedEntry = [[context executeFetchRequest:request error:&errorNew] objectAtIndex:currentIndex.row];
    if(errorNew != nil){
        NSLog(@"Errror");
    }
    
    NSString * currentSubject = [changedEntry valueForKey:@"schoolSubject"];
    
    if(![schoolSubjectTxtBox.text isEqualToString:currentSubject]){
        NSString * colorize = [NSString stringWithString:[pearAppDelegate getStringColorForToDoSubject:schoolSubjectTxtBox.text]];
        NSLog(@"Subject changed, new color %@ for subject %@",colorize, schoolSubjectTxtBox.text);
        [changedEntry setValue:colorize forKey:@"col"];
    }

    [changedEntry setValue:[NSString stringWithString:schoolSubjectTxtBox.text] forKey:@"schoolSubject"];
    [changedEntry setValue:[NSString stringWithString:subjectTxtBox.text] forKey:@"subject"];
    [changedEntry setValue:[NSString stringWithString:dueDateTxtBox.text] forKey:@"due"];
    [changedEntry setValue:[NSString stringWithString:noteTxtBox.text] forKey:@"note"];
    
    if (![context save:&error])
    {
        NSLog(@"Änderungen konnten nicht gespeichert werden!");
    }

}

-(void)setDueDate:(NSDate*)newDate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    NSString * stringTmp = [dateFormatter stringFromDate:newDate];
    
    NSLog(@"Date from Picker: %@",stringTmp);
    
    self.dueDateTxtBox.text = stringTmp;
}

- (IBAction)cancelToDoDetail:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)dateValueChanged:(id)sender{
    [self setDueDate:PckDate.date];
}

- (IBAction)saveToDoDetail:(id)sender {
    [self saveChangedData];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}

- (void) setPickerDate:(NSString*)dueDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    NSDate * dateTemp = [dateFormatter dateFromString:dueDate];
    self.PckDate.date = dateTemp;
}

- (IBAction)schoolSubjectEdit:(id)sender{
    [self.PckSchoolSubjekt reloadAllComponents];
    self.PckSchoolSubjekt.hidden = FALSE;
}

- (IBAction)schoolSubjectEditEnd:(id)sender{
    self.PckSchoolSubjekt.hidden = TRUE;
}
-(void) setCurrentItem:(PearEntryToDo *)newEntry index:(NSIndexPath *)ind{
    self.pearEntryToDo = newEntry;
    self.currentIndex = ind;
}

@end
