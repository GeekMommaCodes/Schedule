//
//  PearTableViewCollector.h
//  Schedule
//
//  Created by Sven Bär on 12.08.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PearTableViewCollector : NSObject

@property NSDictionary *tableViewDictionary;

-(void) addTableView: (NSString *) tableName table:(UIViewController<UITableViewDelegate,UITableViewDataSource> *) tab;

@end
