//
//  PearAppDelegate.h
//  Schedule
//
//  Created by Sven Bär on 21.03.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PearTabBarController.h"
#import "Setup/PearViewControllerSetup.h"
#import "Controller/PearDataModelController.h"
#import "ToDo/PearEntryToDo.h"
#import "Today/PearEntryToday.h"
#import "Util/PearSchoolHour.h"
#import "Util/PearWeekDay.h"
#import "Util/PearSchoolSubject.h"
#import "Util/PearTableViewCollector.h"

#import "TestFlight.h"

@interface PearAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property PearTableViewCollector * tableViewCollector;

/*-----------------------------------*/
@property NSInteger * entryCountToDo;
@property NSMutableArray * entriesToShowToDo;

@property NSInteger * entryCountToday;
@property NSMutableArray * entriesToShowToday;

@property NSInteger * hourPickerCounter;
@property NSMutableArray * hourCollection;
@property NSMutableArray * valuesForHourPicker;

@property NSMutableArray * dayCollection;

@property NSMutableArray *schoolSubjectCollectioon;

@property NSMutableArray *colorCollection;

/*-----------------------------------*/
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

/* -------- tableview --------- */



/*-------------------------------------------*/
- (void) initToDo;
- (void) initToday;
- (void) updateHourPicker;
- (void) updateDayPicker;
- (void) updateScholSubjectPicker;
- (void) updateColorPicker;
- (UIColor *) getHexColorFromString:(NSString *)color;
- (NSString *) getStringColorForToDoSubject:(NSString *)subject;

@end
