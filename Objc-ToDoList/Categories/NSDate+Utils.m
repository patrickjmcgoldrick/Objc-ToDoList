//
//  NSDate+Utils.m
//  Objc-ToDoList
//
//  Created by dirtbag on 12/22/19.
//  Copyright © 2019 dirtbag. All rights reserved.
//

#import "NSDate+Utils.h"

@implementation NSDate (Utils)
- (NSDate *)startOfDay {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [calendar startOfDayForDate:self];
    return date;
}

@end
