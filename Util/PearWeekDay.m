//
//  PearWeekDay.m
//  Schedule
//
//  Created by Sven Bär on 12.06.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import "PearWeekDay.h"

@implementation PearWeekDay
@synthesize WeekDay;

- (id) initWithWeekDay:(NSString *)wd{
    self.WeekDay = wd;
    
    return self;
}

@end
