//
//  PearAddSchoolSubjectViewController.m
//  Schedule
//
//  Created by Sven Bär on 16.06.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import "PearAddSchoolSubjectViewController.h"

@interface PearAddSchoolSubjectViewController ()

@end

@implementation PearAddSchoolSubjectViewController
@synthesize LblDesc;
@synthesize TxtDesc;
@synthesize LblColor;
@synthesize TxtColor;
@synthesize colorPicker;

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
    PearAppDelegate * pearAppDelegate = [[UIApplication sharedApplication] delegate ];   
    [pearAppDelegate updateColorPicker];
    
    self.LblDesc.text = NSLocalizedString(@"SchoolSubject.label", @"");
    self.LblColor.text = NSLocalizedString(@"Color.label", @"");

    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
}

- (void)viewDidUnload
{
    [self setLblDesc:nil];
    [self setTxtDesc:nil];

    [self setColorPicker:nil];
    [self setLblColor:nil];
    [self setTxtColor:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)clearSchoolSubjectValues{
    self.TxtDesc.text = @"";
    self.TxtColor.text = @"";
}

- (IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
    
}

-(BOOL)addNewSchoolSubjectEntry{
    PearAppDelegate * pearAppDelegate = [[UIApplication sharedApplication] delegate ];
    NSManagedObjectContext * context = pearAppDelegate.managedObjectContext;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"SchoolSubject" inManagedObjectContext:context];
    [request setEntity:entity];
    NSError * error = nil;
    
    NSManagedObject * newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"SchoolSubject" inManagedObjectContext:context];
    
    [newEntry setValue:[NSString stringWithString:TxtDesc.text] forKey:@"desc"];
    [newEntry setValue:[NSString stringWithString:TxtColor.text] forKey:@"col"];
    NSLog(@"Color: %@",TxtColor.text);
    
    if (![context save:&error])
    {
        NSLog(@"Fach konnte nicht gespeichert werden!");
        return YES;
    }
    
    return NO;
}

- (IBAction)saveHour:(id)sender{
    if ([self addNewSchoolSubjectEntry] == NO){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert.Save.label",@"") message:NSLocalizedString(@"Alert.SaveHourEntrySuccessful.text",@"") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
        [alert show];  
        [self clearSchoolSubjectValues];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert.Save.labell",@"") message:NSLocalizedString(@"Alert.SaveHourEntryWasntSuccessful.text",@"") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
        [alert show];  
    }
}

- (IBAction)cancelNewHourEntry:(id)sender{
    PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
    [pearAppDelegate updateScholSubjectPicker];
    [self dismissModalViewControllerAnimated:YES];

}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
    
    return [pearAppDelegate.colorCollection objectAtIndex:row];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
    return pearAppDelegate.colorCollection.count;
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
    TxtColor.text = [NSString stringWithFormat:@"%@",[pearAppDelegate.colorCollection objectAtIndex:row]];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

@end
