//
//  PearEntryToday.m
//  Schedule
//
//  Created by Sven Bär on 10.06.12.
//  Copyright (c) 2012 Fruit-IT. All rights reserved.
//

#import "PearEntryToday.h"

@implementation PearEntryToday


@synthesize day;
@synthesize schoolSubject;
@synthesize teacher;
@synthesize room;
@synthesize hour;
@synthesize col;

-(id) initWithTeacher:(NSString *) te schoolSubject:(NSString *) sc room:(NSString *) roo day:(NSString *) da hour:(NSString *) ho color:(NSString *) co{
    self.day = da;
    self.schoolSubject = sc;
    self.teacher = te;
    self.room = roo;
    self.hour = ho;
    self.col = co;
    return self;
}


@end
