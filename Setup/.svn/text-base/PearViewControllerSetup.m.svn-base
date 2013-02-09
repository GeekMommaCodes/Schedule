//
//  PearViewController.m
//  Schedule
//
//  Created by Sven Bär on 22.03.12.
//  Copyright (c) 2012 Fruits-IT. All rights reserved.
//

#import "PearViewControllerSetup.h"
#import "PearAppDelegate.h"

@interface PearViewControllerSetup ()

@end

@implementation PearViewControllerSetup;
@synthesize nameSync;
@synthesize nameSixDays;
@synthesize nameBadge;
@synthesize switchSync;
@synthesize switchSixDays;
@synthesize switchBadge;
@synthesize nameAddButton;
@synthesize nameAddSubject;
@synthesize BtnAddHour;


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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.nameSync.text = NSLocalizedString(@"iCloudSetup.label",@"");
    self.nameSixDays.text = NSLocalizedString(@"SixDaysSetup.label",@"");
    self.nameBadge.text = NSLocalizedString(@"BadgeSetup.label",@"");
    self.nameAddButton.text = NSLocalizedString(@"Button.Hour.add",@"");
    self.nameAddSubject.text = NSLocalizedString(@"Button.SchoolSubject.add",@""); 
    [self initSetupData];
}

- (void)viewDidUnload
{
    [self setNameSync:nil];
    [self setNameSixDays:nil];
    [self setNameBadge:nil];
    [self setSwitchSync:nil];
    [self setSwitchSixDays:nil];
    [self setSwitchBadge:nil];
    [self setBtnAddHour:nil];
    [self setNameAddButton:nil];
    [self setNameAddSubject:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


// Holt die Daten aus der DB und setzt den View
-(void)initSetupData{
    PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext * context = pearAppDelegate.managedObjectContext;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Setup" inManagedObjectContext:context];
    
        NSLog(@"entitiy: %@", entity.name);
        NSLog(@"entitiy: %@", context.debugDescription);
    
    NSManagedObjectModel * model = pearAppDelegate.managedObjectModel;
    
    NSArray * array = [model entities];
    
    for (NSObject * obj in array) {
        NSLog(@"Entities found: %@", obj);
    }
    
    [request setEntity:entity];
    [request setResultType:NSDictionaryResultType];
    NSError * error = nil;
    NSArray * results = [context executeFetchRequest:request error:&error];
    NSUInteger counter = [results count];
    
    if (error != nil || counter == 0){
        [self saveSetupData:TRUE];
        results = [context executeFetchRequest:request error:&error];
    }
    
    NSManagedObjectContext * singleSetupResult = [results lastObject];
    
    NSString * sync =[singleSetupResult valueForKey:@"sync"];
    if ([sync isEqualToString:@"1"]){
        self.switchSync.on = TRUE;
    }else {
         self.switchSync.on = FALSE;
    }
   
    
    NSString * badge =[singleSetupResult valueForKey:@"badge"];
    if ([badge isEqualToString:@"1"] ){
        self.switchBadge.on = TRUE;
    }else {
        self.switchBadge.on = FALSE;
    }
    
    NSString * sixdays =[singleSetupResult valueForKey:@"sixDays"];
    if ([sixdays isEqualToString:@"1"]){
        self.switchSixDays.on = TRUE;
    }else {
        self.switchSixDays.on = FALSE;
    }
    
    
}

// speichert das Setup in die Datenbank
-(void)saveSetupData:(bool) errors{
    PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext * context = pearAppDelegate.managedObjectContext;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Setup" inManagedObjectContext:context];
    [request setEntity:entity];
    NSError * error = nil;
    
    if (errors){
        NSManagedObject * initSetup = [NSEntityDescription insertNewObjectForEntityForName:@"Setup" inManagedObjectContext:context];
        [initSetup setValue:[NSString stringWithString:@"1"] forKey:@"badge"];
        [initSetup setValue:[NSString stringWithString:@"0"] forKey:@"sync"];
        [initSetup setValue:[NSString stringWithString:@"0"] forKey:@"sixDays"];
        if (![context save:&error])
        {
            NSLog(@"Setup konnte nicht initialisiert werden!");
        }
    }else {
        NSError * errorNew = nil;
        NSManagedObject * newSetup = [[context executeFetchRequest:request error:&errorNew] lastObject];
        if(errorNew != nil){
            NSLog(@"Errror");
        }
        if (self.switchBadge.on){
            [newSetup setValue:[NSString stringWithString:@"1"] forKey:@"badge"];
        }else {
            [newSetup setValue:[NSString stringWithString:@"0"] forKey:@"badge"];
        }
        if (self.switchSixDays.on){
            [newSetup setValue:[NSString stringWithString:@"1"] forKey:@"sixDays"];
        }else {
            [newSetup setValue:[NSString stringWithString:@"0"] forKey:@"sixDays"];
        }
        if (self.switchSync.on){
            [newSetup setValue:[NSString stringWithString:@"1"] forKey:@"sync"];
        }else {
            [newSetup setValue:[NSString stringWithString:@"0"] forKey:@"sync"];
        }

        if (![context save:&error])
        {
            NSLog(@"Setup konnte nicht gespeichert werden!");
        }
    }
}

- (IBAction)sendSupportMail:(id)sender {

}

-(IBAction)toggleEnabledForSwitchSync:(id)sender{
    [self saveSetupData:FALSE];
}
-(IBAction)toggleEnabledForSwitchSixDays:(id)sender{
    [self saveSetupData:FALSE];
}
-(IBAction)toggleEnabledForSwitchBadge:(id)sender{
    [self saveSetupData:FALSE];
}

- (IBAction)addButtonClicked:(id)sender {
}

-(IBAction)launchFeedback {
    [TestFlight openFeedbackView];
}
@end
