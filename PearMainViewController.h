//
//  PearMainViewController.h
//  Schedule
//
//  Created by Sven Bär on 21.03.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import "PearTabBarController.h"

@interface PearMainViewController : UIViewController <UITabBarControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@end
