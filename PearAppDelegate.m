//
//  PearAppDelegate.m
//  Schedule
//
//  Created by Sven Bär on 21.03.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import "PearAppDelegate.h"



@implementation PearAppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

/*-----------------------------------*/
@synthesize entryCountToDo, entryCountToday;
@synthesize entriesToShowToDo, entriesToShowToday;
@synthesize valuesForHourPicker, hourCollection;
@synthesize hourPickerCounter;
@synthesize dayCollection;
@synthesize schoolSubjectCollectioon,colorCollection, tableViewCollector;
/*-----------------------------------*/

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // PearTabBarController *controller = (PearTabBarController *)self.window.rootViewController;
    //controller.managedObjectContext = self.managedObjectContext;
    
//    PearViewControllerSetup * setupController = (PearViewControllerSetup*)self;
//    setupController.managedObjectContext = self.managedObjectModel;
    #define TESTING 1
    #ifdef TESTING
        [TestFlight setDeviceIdentifier:[[UIDevice currentDevice] uniqueIdentifier]];
    #endif
    [TestFlight takeOff:@"a938af858ac90ea51d9b92c60df2ff8a_MTQ0MDY1MjAxMi0xMC0xNiAxNDowNjo1Ny4xNTU4NzQ"];
    [self initToDo];
    [self initToday];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Schedule" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Schedule.sqlite"];
    
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,nil];

    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSString *) documentsDirectory {
    //          ------------------
	return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}


/*---------------------------------*/
- (void) initToDo
{
    entryCountToDo = 0;
    PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext * context = pearAppDelegate.managedObjectContext;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Homework" inManagedObjectContext:context];
    [request setEntity:entity];
    [request setResultType:NSDictionaryResultType];
    NSError * error = nil;
    NSArray * results = [context executeFetchRequest:request error:&error];
    NSUInteger counter = [results count];
    
    entriesToShowToDo = [NSMutableArray new]; 
    
    NSDate* tempDate =  [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:tempDate];
    NSDate* currDate = [calendar dateFromComponents:comps];
    if(counter == 0 || error != nil){
        NSLog(@"Error during loading of data from database or no entries in database: %@", error.description );
    }
    
    for (int i = 0; i <counter; i++) {
        NSManagedObjectContext * singleToDoEntry = [results objectAtIndex:i];
        NSString * due =[singleToDoEntry valueForKey:@"due"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd.MM.yyyy"];
        
        if(due != nil){
            NSDate * targetDate = [dateFormatter dateFromString:due];
            NSLog(@"currDate: %@ - Date from Entry: %@",[dateFormatter stringFromDate:currDate],[dateFormatter stringFromDate:targetDate]);


            if(currDate == [currDate earlierDate:targetDate]){                
                NSString * subject =[singleToDoEntry valueForKey:@"subject"];
                NSString * schoolSubject =[singleToDoEntry valueForKey:@"schoolSubject"];
                NSString * note =[singleToDoEntry valueForKey:@"note"];
                NSString * col = [singleToDoEntry valueForKey:@"col"];
                
                if(subject != nil){
                    entryCountToDo++;
                    
                    PearEntryToDo * todo = [[PearEntryToDo alloc] initWithDueDate:due schoolSubject:schoolSubject subject:subject note:note color:col];
                    if(entriesToShowToDo == nil){
                        entriesToShowToDo = [[NSMutableArray alloc] initWithCapacity:counter];
                    }
                    [entriesToShowToDo addObject:todo];
                    NSLog(@"Added ToDoEntry Nr: %@",[NSString stringWithFormat:@"%d", i] );
                }
                else {
                    NSLog(@"Error - invalid  subject found");
                }
            }
            else {
                NSLog(@"Date too old: %@",[dateFormatter stringFromDate:targetDate]);
            }
        }
        else {
            NSLog(@"Error - invalid due date found");
        }
    }
    
    if(entriesToShowToDo.count == 0){
        NSLog(@"Error during filling of data or no entries in database");
    }
}

- (void) initToday
{
    entryCountToday = 0;
    PearAppDelegate * pearAppDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext * context = pearAppDelegate.managedObjectContext;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"SchoolHour" inManagedObjectContext:context];
    [request setEntity:entity];
    [request setResultType:NSDictionaryResultType];
    NSError * error = nil;
    NSArray * results = [context executeFetchRequest:request error:&error];
    NSUInteger counter = [results count];
    
    entriesToShowToday = [NSMutableArray new]; 
    
    if(counter == 0 || error != nil){
        NSLog(@"Error during loading of data from database: %@", error.description );
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];  
    [dateFormatter setDateFormat:@"EEEE"];
    NSString * today = [dateFormatter stringFromDate:[NSDate date]];
    NSLog(@"Weekday from today - %@",[dateFormatter stringFromDate:[NSDate date]]);

    for (int i = 0; i <counter; i++) {
        NSManagedObjectContext * singleTodayEntry = [results objectAtIndex:i];
        
        NSString * tempDay = [singleTodayEntry valueForKey:@"day"];
        
        
        if([tempDay isEqualToString:today]){
            NSString * schoolSubject =[singleTodayEntry valueForKey:@"schoolSubject"];
            NSString * hour =[singleTodayEntry valueForKey:@"hour"];
            NSString * teacher =[singleTodayEntry valueForKey:@"teacher"];
            NSString * room = [singleTodayEntry valueForKey:@"room"];
            NSString * col = [singleTodayEntry valueForKey:@"col"]; 

            if(schoolSubject != nil){
                entryCountToday++;
                if(col == nil){
                    col = @"ffffff";
                }
                PearEntryToday * today = [[PearEntryToday alloc] initWithTeacher:teacher schoolSubject:schoolSubject room:room day:tempDay hour:hour color:col];
                if(entriesToShowToday == nil){
                    entriesToShowToday = [[NSMutableArray alloc] initWithCapacity:counter];
                }
                [entriesToShowToday addObject:today];
                NSLog(@"Added TodayEntry Nr: %@",[NSString stringWithFormat:@"%d", i] );
            }else {
                NSLog(@"Error - invalid  subject found");
            }
        }else {
            NSLog(@"Weekday from entry - %@",tempDay);
        }
    }
    
    if(entriesToShowToday.count == 0){
        NSLog(@"Error during filling of data for Today-List");
    }
}


- (void) updateHourPicker{
    hourPickerCounter = 0;
    NSManagedObjectContext * context = self.managedObjectContext;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"HourModel" inManagedObjectContext:context];
    [request setEntity:entity];
    [request setResultType:NSDictionaryResultType];
    NSError * error = nil;
    NSArray * results = [context executeFetchRequest:request error:&error];
    NSUInteger counterLoc = [results count];
    
    // hourManager.hourCollection = [NSMutableArray new]; 
    
    if(counterLoc == 0 || error != nil){
        NSLog(@"Error during loading of data from database in hourmanager: %@", error.description );
    }
    
    if (hourCollection != nil){
        [hourCollection removeAllObjects];
    }

    for (int i = 0; i <counterLoc; i++) {
        NSManagedObjectContext * singleHourEntry = [results objectAtIndex:i];
        
        NSString * start =[singleHourEntry valueForKey:@"start"];
        NSString * end =[singleHourEntry valueForKey:@"end"];
        NSString * pause =[singleHourEntry valueForKey:@"pause"];
        
                
        if(start != nil){
            hourPickerCounter++;
            
            PearSchoolHour * hourEntry = [[PearSchoolHour alloc] initWithIsPause:pause startingTime:start endingTime:end];
            if(hourCollection == nil){
                 hourCollection = [[NSMutableArray alloc] initWithCapacity:counterLoc];
            }
            [hourCollection addObject:hourEntry];
            NSLog(@"Added Hour Nr: %@ - Pause %@",[NSString stringWithFormat:@"%d", i], hourEntry.isPause );
        }
        else {
            NSLog(@"Error - invalid  start found");
        }
        
        
    }
    
    if(hourCollection.count == 0){
        NSLog(@"Error during filling of data for hourmanager");
    }
}

- (void) updateDayPicker{
    
    if (dayCollection != nil){
        [dayCollection removeAllObjects];
    }
    
    NSString * weekdayName;
    
    for (int i = 0; i <7; i++) {
        switch (i) {
            case 0:
                weekdayName = NSLocalizedString(@"Monday.picker",@"");
                break;
            case 1:
                weekdayName = NSLocalizedString(@"Tuesday.picker",@"");
                break;
            case 2:
                weekdayName = NSLocalizedString(@"Wednesday.picker",@"");
                break;
            case 3:
                weekdayName = NSLocalizedString(@"Thursday.picker",@"");
                break;
            case 4:
                weekdayName = NSLocalizedString(@"Friday.picker",@"");
                break;
            case 5:
               weekdayName = NSLocalizedString(@"Saturday.picker",@"");
                break;
            case 6:
                weekdayName = NSLocalizedString(@"Sunday.picker",@"");
                break;
            default:
                break;
        }
        
        PearWeekDay * weekdayEntry = [[PearWeekDay alloc] initWithWeekDay:weekdayName];
        
        if(dayCollection == nil){
            dayCollection = [[NSMutableArray alloc] initWithCapacity:6];
        }
        [dayCollection addObject:weekdayEntry];
        NSLog(@"Added Day Nr: %@ - Tag: %@",[NSString stringWithFormat:@"%d", i], weekdayEntry.WeekDay );

        
        
    }
    
    if(hourCollection.count == 0){
        NSLog(@"Error during filling of data for weekday");
    }

}

-(void) updateColorPicker{
    
    NSString * colorName;
    for (int i = 0; i <10; i++) {
        switch (i) {
            case 0:
                colorName = NSLocalizedString(@"color.white",@"");
                break;
            case 1:
                colorName = NSLocalizedString(@"color.yellow",@"");
                break;
            case 2:
                colorName = NSLocalizedString(@"color.red",@"");
                break;
            case 3:
                colorName = NSLocalizedString(@"color.orange",@"");
                break;
            case 4:
                colorName = NSLocalizedString(@"color.violett",@"");
                break;
            case 5:
                colorName = NSLocalizedString(@"color.blue",@"");
                break;
            case 6:
                colorName = NSLocalizedString(@"color.green",@"");
                break;
            case 7:
                colorName = NSLocalizedString(@"color.gray",@"");
                break;
            case 8:
                colorName = NSLocalizedString(@"color.pink",@"");
                break;
            case 9:
                colorName = NSLocalizedString(@"color.brown",@"");
                break;
            default:
                break;
        }
        
        if(colorCollection == nil){
            colorCollection = [[NSMutableArray alloc] initWithCapacity:10];
        }
        [colorCollection addObject:colorName];
        NSLog(@"Added Color: %@ to colorCollection",colorName );
        
        
        
    }
    
    if(colorCollection.count == 0){
        NSLog(@"Error during filling of data for colors");
    }

}

- (NSString *) getStringColorForToDoSubject:(NSString *)subject{
    [self updateScholSubjectPicker];
    PearSchoolSubject * targetSubject;    
    for (int i = 0; i< [self.schoolSubjectCollectioon count];i++){
        targetSubject = [self.schoolSubjectCollectioon objectAtIndex:i];
        if([targetSubject.desc isEqualToString:subject]){
            break;
        }
    }
    if (targetSubject == nil) {
        NSLog(@"No subject '%@' found - available subjects:", subject);
        for (int i = 0; i< [self.schoolSubjectCollectioon count];i++){
            targetSubject = [self.schoolSubjectCollectioon objectAtIndex:i]; 
            NSLog(@"%@",targetSubject.desc);
        }
    }
    if(targetSubject.color == nil){
        NSLog(@"Invalid Color: Nil!");
    }
    return targetSubject.color;    
}

- (UIColor *) getHexColorFromString:(NSString *)color{
          
    if([color isEqualToString:NSLocalizedString(@"color.brown",@"")]){
        return [UIColor brownColor];
    }
    else if([color isEqualToString:NSLocalizedString(@"color.green",@"")]){
        return [UIColor greenColor];
    }
    else if([color isEqualToString:NSLocalizedString(@"color.yellow",@"")]){
        return [UIColor yellowColor];
    }
    else if([color isEqualToString:NSLocalizedString(@"color.gray",@"")]){
        return [self colorWithHexString:@"888888"];
    }
    else if([color isEqualToString:NSLocalizedString(@"color.red",@"")]){
        return [self colorWithHexString:@"ff0000"];
    }
    else if([color isEqualToString:NSLocalizedString(@"color.blue",@"")]){
        return [self colorWithHexString:@"0000ff"];
    }
    else if([color isEqualToString:NSLocalizedString(@"color.orange",@"")]){
        return [self colorWithHexString:@"f29d1e"];
    }
    else if([color isEqualToString:NSLocalizedString(@"color.pink",@"")]){
        return [self colorWithHexString:@"ff00bb"];
    }
    else if([color isEqualToString:NSLocalizedString(@"color.violett",@"")]){
        return [self colorWithHexString:@"bf00ff"];
    }
    else if([color isEqualToString:NSLocalizedString(@"Dash.sectionheader.color",@"")]){
        return [self colorWithHexString:@"2183c4"];
    }
    else {
        return  [self colorWithHexString:@"ffffff"];
    }
}

-(UIColor*)colorWithHexString:(NSString*)hex  
{  
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];  
    
    // String should be 6 or 8 characters  
    if ([cString length] < 6) return [UIColor grayColor];  
    
    // strip 0X if it appears  
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];  
    
    if ([cString length] != 6) return  [UIColor grayColor];  
    
    // Separate into r, g, b substrings  
    NSRange range;  
    range.location = 0;  
    range.length = 2;  
    NSString *rString = [cString substringWithRange:range];  
    
    range.location = 2;  
    NSString *gString = [cString substringWithRange:range];  
    
    range.location = 4;  
    NSString *bString = [cString substringWithRange:range];  
    
    // Scan values  
    unsigned int r, g, b;  
    [[NSScanner scannerWithString:rString] scanHexInt:&r];  
    [[NSScanner scannerWithString:gString] scanHexInt:&g];  
    [[NSScanner scannerWithString:bString] scanHexInt:&b];  
    
    UIColor * color = [UIColor colorWithRed:((float) r / 255.0f)  
                                      green:((float) g / 255.0f)  
                                       blue:((float) b / 255.0f)  
                                      alpha:1.0f];
    
    
    return color;  
} 

- (void) updateScholSubjectPicker{
    if (schoolSubjectCollectioon != nil){
        [schoolSubjectCollectioon removeAllObjects];
    }
    
    NSManagedObjectContext * context = self.managedObjectContext;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"SchoolSubject" inManagedObjectContext:context];
    [request setEntity:entity];
    [request setResultType:NSDictionaryResultType];
    NSError * error = nil;
    NSArray * results = [context executeFetchRequest:request error:&error];
    NSUInteger counterLoc = [results count];
    
    // hourManager.hourCollection = [NSMutableArray new]; 
    
    if(counterLoc == 0 || error != nil){
        NSLog(@"Error during loading of data from database in schoolsubject: %@", error.description );
    }
    
    
    for (int i = 0; i <counterLoc; i++) {
        NSManagedObjectContext * singeSchoolSubjectEntry = [results objectAtIndex:i];
        
        NSString * desc =[singeSchoolSubjectEntry valueForKey:@"desc"];
        NSString * color =[singeSchoolSubjectEntry valueForKey:@"col"];
        
        
        if(desc != nil){
            PearSchoolSubject * schoolSubjectEntry = [[PearSchoolSubject alloc] initWithColor:color desc:desc];
            if(schoolSubjectCollectioon== nil){
                schoolSubjectCollectioon = [[NSMutableArray alloc] initWithCapacity:counterLoc];
            }
            if(schoolSubjectEntry != nil){
                [schoolSubjectCollectioon addObject:schoolSubjectEntry];    
            }
            
            NSLog(@"Added Hour Nr: %@ - desc %@",[NSString stringWithFormat:@"%d", i], schoolSubjectEntry.desc );
        }
        else {
            NSLog(@"Error - invalid  desc found");
        }
        
        
    }
    
    if(schoolSubjectCollectioon.count == 0){
        NSLog(@"Error during filling of data for schoolsubject");
    }

}
@end
