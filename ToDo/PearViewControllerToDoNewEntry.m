//
//  PearViewControllerToDoNewEntry.m
//  Schedule
//
//  Created by Sven Bär on 03.05.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import "PearViewControllerToDoNewEntry.h"


@interface PearViewControllerToDoNewEntry ()

@end

@implementation PearViewControllerToDoNewEntry
@synthesize schoolSubject;
@synthesize due;
@synthesize subject;
@synthesize note;

@synthesize schoolSubjectTxtBox;
@synthesize dueTxtBox;
@synthesize subjectTxtBox;
@synthesize noteTxtBox;
@synthesize datePicker;
@synthesize subjectPicker;
@synthesize subjectFlag;



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
    [self doLoad];
}

- (void)viewDidUnload
{

    [self setSchoolSubject:nil];
    [self setDue:nil];
    [self setSubject:nil];
    [self setNote:nil];
    [self setSchoolSubjectTxtBox:nil];
    [self setDueTxtBox:nil];
    [self setSubjectTxtBox:nil];
    [self setNoteTxtBox:nil];
    [self setDatePicker:nil];
    [self setSubjectPicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    UITableViewController * viewController = (UITableViewController *) self.parentViewController;
//    [viewController.tableView reloadData];
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(void) doLoad
{
    [super viewDidLoad];
    PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
    [pearAppDelegate updateHourPicker];
    [pearAppDelegate updateDayPicker];
    [pearAppDelegate updateScholSubjectPicker];
    
    UIView * dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    schoolSubjectTxtBox.inputView = dummyView;
    
    
    if([pearAppDelegate.schoolSubjectCollectioon objectAtIndex:0] == nil){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert.Save.label",@"") message:NSLocalizedString(@"Alert.AddSchoolSubject.text",@"") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

	// Do any additional setup after loading the view.
    self.schoolSubject.text = NSLocalizedString(@"SchoolSubject.label",@"");
    self.due.text = NSLocalizedString(@"Due.label",@"");
    self.subject.text = NSLocalizedString(@"Subject.label",@"");
    self.note.text = NSLocalizedString(@"Note.label", @"");
    
    NSDate *currDate = [NSDate date];
    [self setDueDate:currDate];

}

// speichert einen neuen Eintrag in der Tabelle "Homework"
-(BOOL)addNewToDoEntry{
    PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext * context = pearAppDelegate.managedObjectContext;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Homework" inManagedObjectContext:context];
    [request setEntity:entity];
    NSError * error = nil;
    
    NSManagedObject * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Homework" inManagedObjectContext:context];
    
    [newEntry setValue:[NSString stringWithString:schoolSubjectTxtBox.text] forKey:@"schoolSubject"];
    [newEntry setValue:[NSString stringWithString:dueTxtBox.text] forKey:@"due"];
    [newEntry setValue:[NSString stringWithString:subjectTxtBox.text] forKey:@"subject"];
    [newEntry setValue:[NSString stringWithString:noteTxtBox.text] forKey:@"note"];
    
    NSString * colorize = [NSString stringWithString:[pearAppDelegate getStringColorForToDoSubject:schoolSubjectTxtBox.text]]; 
    NSLog(@"Color will be saved: %@",colorize );
    [newEntry setValue:colorize forKey:@"col"];
    
    
    
    if (![context save:&error])
    {
        NSLog(@"Aufgabe konnte nicht gespeichert werden!");
        return YES;
    }
    
    [pearAppDelegate initToDo];
    
    UIViewController<UITableViewDelegate,UITableViewDataSource> * table = [pearAppDelegate.tableViewCollector valueForKey:@"todo"];
    [table viewWillAppear:YES];
    
    UIViewController<UITableViewDelegate,UITableViewDataSource> * tableDash = [pearAppDelegate.tableViewCollector valueForKey:@"todo"];
    [tableDash viewWillAppear:YES];
    
    return NO;
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

-(void)setDueDate:(NSDate*)newDate{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    
    self.dueTxtBox.text = [dateFormatter stringFromDate:newDate];
}

- (IBAction)saveEntry:(id)sender {
    if ([self addNewToDoEntry] == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert.Save.label",@"") message:NSLocalizedString(@"Alert.SaveToDoEntrySuccessful.text",@"") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
        [alert show];  
        PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
        [pearAppDelegate initToDo];
        [self dismissModalViewControllerAnimated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert.Save.labell",@"") message:NSLocalizedString(@"Alert.SaveToDoEntryWasntSuccessful.text",@"") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
        [alert show];  
    }
    
}



- (IBAction)datePickerChanged:(id)sender {
    [self setDueDate:self.datePicker.date];
}

- (IBAction)cancelNewToDoEntry:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)schoolSubjectChanged:(id)sender {
}

- (IBAction)dueChanged:(id)sender {
}

- (IBAction)subjectChanged:(id)sender {
}

- (IBAction)noteChanged:(id)sender {
}

- (IBAction)schoolSubjectEdit:(id)sender{
    [self.subjectPicker reloadAllComponents];
    self.subjectPicker.hidden = FALSE;
}

- (IBAction)schoolSubjectEditEnd:(id)sender{
    self.subjectPicker.hidden = TRUE;
}
- (IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
    
}

@end
