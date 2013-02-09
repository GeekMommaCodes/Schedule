//
//  PearTableViewCollector.m
//  Schedule
//
//  Created by Sven Bär on 12.08.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import "PearTableViewCollector.h"

@implementation PearTableViewCollector

@synthesize tableViewDictionary;

-(void) addTableView:(NSString *)tableName table:(UIViewController<UITableViewDelegate,UITableViewDataSource> *)tab{
    if(tableViewDictionary == nil){
        tableViewDictionary = [NSDictionary init];
    }
    [tableViewDictionary setValue:tab forKey:tableName];
    
}

@end
