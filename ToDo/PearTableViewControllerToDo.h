//
//  PearTableViewControllerToDo.h
//  Schedule
//
//  Created by Sven Bär on 22.03.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PearAppDelegate.h"
#import "PearEntryToDo.h"
#import "PearViewControllerToDoDetail.h"
#import "../Util/PearTableViewCollector.h"

@interface PearTableViewControllerToDo : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property UITableView * tableViewToDo;
@property NSIndexPath * selectedRow;
@property int * prepareSegueCounter;
@property PearViewControllerToDoDetail *pearViewControllerToDoDetail;
@property bool isInitialized;

@end
