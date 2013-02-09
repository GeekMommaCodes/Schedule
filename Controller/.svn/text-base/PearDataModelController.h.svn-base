//
//  PearDataModelController.h
//  Schedule
//
//  Created by Sven Bär on 27.03.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../PearAppDelegate.h"

@interface PearDataModelController : NSObject
{
    NSManagedObjectModel * objectModel;
    NSPersistentStoreCoordinator * storeCoordinator;
    NSManagedObjectContext * context;
}

-(void)start;
-(NSManagedObjectModel *)objectModel;
-(NSPersistentStoreCoordinator *)storeCoordinator;
-(NSManagedObjectContext *)context;

-(void)setContext:(NSManagedObjectContext *)context;
-(void)setObjectModel:(NSManagedObjectModel *)objectModel;
-(void)setStoreCoordinator:(NSPersistentStoreCoordinator *)storeCoordinator;
@end
