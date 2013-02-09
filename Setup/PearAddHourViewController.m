//
//  PearAddHourViewController.m
//  Schedule
//
//  Created by Sven Bär on 10.06.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import "PearAddHourViewController.h"

@interface PearAddHourViewController ()

@end

@implementation PearAddHourViewController
@synthesize LblStartTime;
@synthesize LblEndTime;
@synthesize LblIsPause;
@synthesize TxtStartTime;
@synthesize TxtEndTime;
@synthesize SwIsPause;
@synthesize PckTime;
@synthesize startFlag;

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
    self.LblStartTime.text = NSLocalizedString(@"Starttime.label", @"");
    self.LblEndTime.text = NSLocalizedString(@"Endtime.label", @"");
    self.LblIsPause.text = NSLocalizedString(@"Pause.label", @"");
    

    UIView * dummyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    TxtStartTime.inputView = dummyView;
    TxtEndTime.inputView = dummyView;
    self.SwIsPause.on = NO;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setLblStartTime:nil];
    [self setLblEndTime:nil];
    [self setLblIsPause:nil];
    [self setTxtStartTime:nil];
    [self setTxtEndTime:nil];
    [self setSwIsPause:nil];
    [self setPckTime:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) clearHourValues{
    self.TxtStartTime.text = self.TxtEndTime.text;
    self.TxtEndTime.text = @"";
    self.SwIsPause.on = NO;
    
}
-(BOOL)addNewHourEntry{
    PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext * context = pearAppDelegate.managedObjectContext;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"HourModel" inManagedObjectContext:context];
    [request setEntity:entity];
    NSError * error = nil;
    
    NSManagedObject * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"HourModel" inManagedObjectContext:context];
    

    if (self.SwIsPause.on){
        [newEntry setValue:[NSString stringWithString:@"1"] forKey:@"pause"];
    }else {
        [newEntry setValue:[NSString stringWithString:@"0"] forKey:@"pause"];
    }

    [newEntry setValue:[NSString stringWithString:TxtStartTime.text] forKey:@"start"];
    [newEntry setValue:[NSString stringWithString:TxtEndTime.text] forKey:@"end"];
    
    if (![context save:&error])
    {
        NSLog(@"Schulstunde konnte nicht gespeichert werden!");
        return YES;
    }
    
    return NO;
}


- (IBAction)startDateEdit:(id)sender {
    [self setStartFlag:FALSE];
}

- (IBAction)endDateEdit:(id)sender {
    [self setStartFlag:TRUE];
}

- (IBAction)saveHour:(id)sender {
    if ([self addNewHourEntry] == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert.Save.label",@"") message:NSLocalizedString(@"Alert.SaveHourEntrySuccessful.text",@"") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
        [alert show];  
        [self clearHourValues];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert.Save.labell",@"") message:NSLocalizedString(@"Alert.SaveHourEntryWasntSuccessful.text",@"") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
        [alert show];  
    }

}

- (IBAction)cancelNewHourEntry:(id)sender {
    PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
    [pearAppDelegate updateHourPicker];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
    
}

- (IBAction)datePickerValueChanged:(id)sender {
    [self setDateFromDatePicker:PckTime.date];
}

- (void)setDateFromDatePicker:(NSDate *)inDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh:mm"];

    if(!startFlag){
        self.TxtStartTime.text = [dateFormatter stringFromDate:inDate];

    }else {
        self.TxtEndTime.text = [dateFormatter stringFromDate:inDate];
    }    
}
@end
