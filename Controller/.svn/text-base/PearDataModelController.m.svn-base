//
//  PearDataModelController.m
//  Schedule
//
//  Created by Sven Bär on 27.03.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import "PearDataModelController.h"

@implementation PearDataModelController

//NSManagedObjectModel * objectModel;
//NSPersistentStoreCoordinator * storeCoordinator;
//NSManagedObjectContext * context;

-(void)start{
    self.objectModel = self.objectModel;
}


-(NSManagedObjectModel *)objectModel{
    if (objectModel != nil){
        return objectModel;
    }
   
    
    // Sucht nur das spezielle Bundle mit dem Namen
//    NSURL * modelURL = [[NSBundle mainBundle] URLForResource:@"Schedule" withExtension:@"momd"];
//    objectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    // Sucht nach allen Bundles im Projekt
    objectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return objectModel;
}

-(NSPersistentStoreCoordinator *)storeCoordinator{
    if (storeCoordinator != nil){
        return storeCoordinator;
    }
    
    NSString * appPath = [[NSBundle mainBundle] resourcePath];
    NSURL * storeURL = [NSURL fileURLWithPath:[appPath stringByAppendingPathComponent:@"Schedule.sqlite"]];  
    NSError * error;
    
    storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.objectModel];
    
    if (![storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]){
        // Handle Error
    }
    
    return storeCoordinator;
}

-(NSManagedObjectContext *)context{
    if(context != nil){
        return context;
    }
    
    
    NSPersistentStoreCoordinator * coordinator = self.storeCoordinator;
    if(coordinator != nil){
//        context = [(PearAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:coordinator];
    }
    
    return context;
}

-(void)setContext:(NSManagedObjectContext *)context{

}

-(void)setObjectModel:(NSManagedObjectModel *)objectModel{
  
}

-(void)setStoreCoordinator:(NSPersistentStoreCoordinator *)storeCoordinator{
   
}

@end
