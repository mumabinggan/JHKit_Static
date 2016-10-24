//
//  NSDate+JHKit.m
//  JHKit
//
//  Created by muma on 2016/10/16.
//  Copyright © 2016年 mumuxinxinCompany. All rights reserved.
//

#import "NSDate+JHKit.h"

@implementation NSDate (JHKit)

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (NSDateComponents *)components {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
    return [calendar components:unitFlags fromDate:self];
}

- (NSInteger)year {
    return self.components.year;
}

- (NSInteger)month {
    return self.components.month;
}

- (NSInteger)day {
    return self.components.day;
}

- (NSInteger)hour {
    return self.components.hour;
}

- (NSInteger)minute {
    return self.components.minute;
}

- (NSInteger)second {
    return self.components.second;
}

+ (NSDate *)dateFromString:(NSString *)string {
    return [NSDate dateFromString:string withFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:string];
    formatter = nil;
    return date;
}

@end
