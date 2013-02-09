//
//  PearViewControllerTodayViewController.m
//  Schedule
//
//  Created by Sven Bär on 10.06.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import "PearViewControllerTodayNewEntry.h"

@interface PearViewControllerTodayNewEntry ()

@end

@implementation PearViewControllerTodayNewEntry
@synthesize LblSubject;
@synthesize TxtSubject;
@synthesize LblTeacher;
@synthesize TxtTeacher;
@synthesize LblRoom;
@synthesize TxtRoom;
@synthesize PckHour;
@synthesize PckDay;
@synthesize PckSchoolSubject;
@synthesize LblHour;
@synthesize TxtHour;
@synthesize LblDay;
@synthesize TxtDay;


@synthesize dayFlag,hourFlag;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //do init stuff
    }
    return self;
}

- (void)initValues
{
    if(dayFlag && !hourFlag){
        self.PckHour.alpha = 0.0;
        self.PckHour.hidden = true;
        self.PckDay.hidden = false;
        self.PckSchoolSubject.hidden = true;
    }else if(!dayFlag && hourFlag){
        self.PckDay.alpha = 0.0;
        self.PckDay.hidden = true;
        self.PckHour.hidden = false;
        self.PckSchoolSubject.hidden = true;
    }else {
        self.PckDay.alpha = 0.0;
        self.PckDay.hidden = true;
        self.PckHour.hidden = true;
        self.PckSchoolSubject.hidden = false;
        
    }
    
    LblSubject.text = NSLocalizedString(@"SchoolSubject.label",@"");
    LblTeacher.text = NSLocalizedString(@"Teacher.label",@"");
    LblHour.text = NSLocalizedString(@"Hour.label",@"");
    LblRoom.text = NSLocalizedString(@"Room.label",@"");
    LblDay.text = NSLocalizedString(@"Weekday.label",@"");
}

- (void)viewDidLoad
{
    PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
    [pearAppDelegate updateHourPicker];
    [pearAppDelegate updateDayPicker];
    [pearAppDelegate updateScholSubjectPicker];
    
    if([pearAppDelegate.hourCollection objectAtIndex:0] != nil){
        PearSchoolHour * pearSchoolHour =  [pearAppDelegate.hourCollection objectAtIndex:0];
        if ([pearSchoolHour.isPause isEqualToString:@"0"]){
            TxtHour.text = [NSString stringWithFormat:@"%@ - %@", pearSchoolHour.startingTime, pearSchoolHour.endingTime]; 
        }else {
            TxtHour.text = [NSString stringWithFormat:@"%@ - %@ (Pause)", pearSchoolHour.startingTime, pearSchoolHour.endingTime];
        }
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert.Save.label",@"") message:NSLocalizedString(@"Alert.AddSchoolHour.text",@"") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
        [alert show];  
    }
    
    if([pearAppDelegate.schoolSubjectCollectioon objectAtIndex:0] == nil){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert.Save.label",@"") message:NSLocalizedString(@"Alert.AddSchoolSubject.text",@"") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
        [alert show];  
    }
    
    PearWeekDay * pearWeekDay = [pearAppDelegate.dayCollection objectAtIndex:0];
    TxtDay.text = [NSString stringWithFormat:@"%@",pearWeekDay.WeekDay];
    
    UIView * dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    TxtDay.inputView = dummyView;
    TxtHour.inputView = dummyView;
    TxtSubject.inputView = dummyView;
    
    [self initValues];
    [super viewDidLoad];
    
}

- (void)viewDidUnload
{
    [self setLblSubject:nil];
    [self setTxtSubject:nil];
    [self setLblTeacher:nil];
    [self setTxtTeacher:nil];
    [self setLblRoom:nil];
    [self setTxtRoom:nil];
    [self setPckHour:nil];
    [self setLblHour:nil];
    [self setTxtHour:nil];
    [self setLblDay:nil];
    [self setTxtDay:nil];
    [self setPckDay:nil];
    [self setPckSchoolSubject:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) viewDidAppear:(BOOL)animated{
    PearTableViewControllerToday * viewController = (PearTableViewControllerToday *) self.parentViewController;
    [viewController.tableViewToday reloadData];
    
    [super viewDidAppear:animated];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
    
    if(dayFlag && !hourFlag){
        return pearAppDelegate.dayCollection.count;
    }else if(!dayFlag && hourFlag){
        return pearAppDelegate.hourCollection.count;
    }else {
        return pearAppDelegate.schoolSubjectCollectioon.count;
    }

}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
    
    NSString * title;
    if(dayFlag && !hourFlag){
        PearWeekDay * pearWeekDay = [pearAppDelegate.dayCollection objectAtIndex:row];
        
        title = [NSString stringWithFormat:@"%@", pearWeekDay.WeekDay];
    }else if(!dayFlag && hourFlag){
        PearSchoolHour * pearSchoolHour = [pearAppDelegate.hourCollection objectAtIndex:row];
        
        if ([pearSchoolHour.isPause isEqualToString:@"0"]){
            title = [NSString stringWithFormat:@"%@ - %@", pearSchoolHour.startingTime, pearSchoolHour.endingTime]; 
        }else {
            title = [NSString stringWithFormat:@"%@ - %@ (Pause)", pearSchoolHour.startingTime, pearSchoolHour.endingTime];
        }

    
    }else {
        PearSchoolSubject * pearSchoolSubject = [pearAppDelegate.schoolSubjectCollectioon objectAtIndex:row];
        
        title = [NSString stringWithFormat:@"%@", pearSchoolSubject.desc];
    }
       return title;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
    if(dayFlag && !hourFlag){
        PearWeekDay * pearWeekDay = [pearAppDelegate.dayCollection objectAtIndex:row];
        TxtDay.text = [NSString stringWithFormat:@"%@", pearWeekDay.WeekDay];
    }else if(!dayFlag && hourFlag){
        PearSchoolHour * pearSchoolHour =  [pearAppDelegate.hourCollection objectAtIndex:row];
        if ([pearSchoolHour.isPause isEqualToString:@"0"]){
            TxtHour.text = [NSString stringWithFormat:@"%@ - %@", pearSchoolHour.startingTime, pearSchoolHour.endingTime];
        }else {
            TxtHour.text = [NSString stringWithFormat:@"%@ - %@ (Pause)", pearSchoolHour.startingTime, pearSchoolHour.endingTime];
        }
    }else {
        PearSchoolSubject * pearSchoolSubject = [pearAppDelegate.schoolSubjectCollectioon objectAtIndex:row];
        TxtSubject.text = [NSString stringWithFormat:@"%@", pearSchoolSubject.desc];
    }
    
}

// speichert einen neuen Eintrag in der Tabelle "Homework"
-(BOOL)addNewTodayEntry{
    PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext * context = pearAppDelegate.managedObjectContext;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"SchoolHour" inManagedObjectContext:context];
    [request setEntity:entity];
    NSError * error = nil;
    
    NSManagedObject * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"SchoolHour" inManagedObjectContext:context];
    
    [newEntry setValue:[NSString stringWithString:TxtSubject.text] forKey:@"schoolSubject"];
    [newEntry setValue:[NSString stringWithString:TxtRoom.text] forKey:@"room"];
    [newEntry setValue:[NSString stringWithString:TxtTeacher.text] forKey:@"teacher"];
    [newEntry setValue:[NSString stringWithString:TxtHour.text] forKey:@"hour"];
    [newEntry setValue:[NSString stringWithString:TxtDay.text] forKey:@"day"];
    [newEntry setValue:[NSString stringWithString:[pearAppDelegate getStringColorForToDoSubject:TxtSubject.text]] forKey:@"col"];
    if (![context save:&error])
    {
        NSLog(@"Schulstunde konnte nicht gespeichert werden!");
        return YES;
    }
    
    [pearAppDelegate initToday];
    UIViewController<UITableViewDelegate,UITableViewDataSource> * tableViewToday = [pearAppDelegate.tableViewCollector valueForKey:@"today"];
    [tableViewToday viewWillAppear:YES];
    
    UIViewController<UITableViewDelegate,UITableViewDataSource> * tableViewDash = [pearAppDelegate.tableViewCollector valueForKey:@"today"];
    [tableViewDash viewWillAppear:YES];
    
    return NO;
}



- (IBAction)saveEntry:(id)sender {
    if ([self addNewTodayEntry] == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert.Save.label",@"") message:NSLocalizedString(@"Alert.SaveTodayEntrySuccessful.text",@"") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
        [alert show];  
        PearAppDelegate *pearAppDelegate = (PearAppDelegate *)[[UIApplication sharedApplication]delegate];
        [pearAppDelegate initToday];
        [self dismissModalViewControllerAnimated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert.Save.labell",@"") message:NSLocalizedString(@"Alert.SaveTodayEntryWasntSuccessful.text",@"") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
        [alert show];  
    }
    
}



- (IBAction)cancelNewTodayEntry:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}


- (IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}


- (IBAction)weekDayEdit:(id)sender{
    [self setDayFlag:TRUE];
    [self setHourFlag:FALSE];
    [self.PckDay reloadAllComponents];
    [self.PckHour reloadAllComponents];
    [self.PckSchoolSubject reloadAllComponents];
}

- (IBAction)hourEdit:(id)sender{
    [self setDayFlag:FALSE];
    [self setHourFlag:TRUE];
    [self.PckDay reloadAllComponents];
    [self.PckHour reloadAllComponents];
    [self.PckSchoolSubject reloadAllComponents];
}

- (IBAction)schoolSubjectEdit:(id)sender{
    [self setDayFlag:FALSE];
    [self setHourFlag:FALSE];
    [self.PckDay reloadAllComponents];
    [self.PckHour reloadAllComponents];
    [self.PckSchoolSubject reloadAllComponents];
}

@end
