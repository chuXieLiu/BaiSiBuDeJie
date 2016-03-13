//
//  NSDate+BSExtension.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/12.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "NSDate+BSExtension.h"


@implementation NSDate (BSExtension)


- (BOOL)isThisYear
{
    NSCalendarUnit unit = NSCalendarUnitYear;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:unit fromDate:self toDate:[NSDate date] options:0];
    return components.year == 0;
}

- (BOOL)isToday
{
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *nowComponents = [[NSCalendar currentCalendar] components:unit fromDate: [NSDate date]];
    NSDateComponents *selfComponents = [[NSCalendar currentCalendar] components:unit fromDate: self];
    return nowComponents.year == selfComponents.year
    && nowComponents.month == selfComponents.month
    && nowComponents.day == selfComponents.day;
}

- (BOOL)isYesterday
{
    NSDateFormatter *frmt = [BSHelper dateFormatter];
    [frmt setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [frmt dateFromString:[frmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [frmt dateFromString:[frmt stringFromDate:self]];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:unit fromDate:selfDate toDate:date options:0];
    return !components.year && !components.month && components.day == 1;
}



- (NSDateComponents *)deltaFrom:(NSDate *)startdate
{
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [[NSCalendar currentCalendar] components:unit fromDate:startdate toDate:self options:0];
}

@end
