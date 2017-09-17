//
//  NSString+NSStringExtension.m
//  MyWechat
//
//  Created by huangsunyang on 8/30/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+ (NSString *)stringFromDate: (NSDate *) date {
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:
                              NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                             fromDate:date];
    NSDateComponents *NOWComp = [[NSCalendar currentCalendar] components:
                                 NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                                fromDate:[NSDate date]];
    NSInteger day = [comp day];
    NSInteger month = [comp month];
    NSInteger year = [comp year];
    NSInteger hour = [comp hour];
    NSInteger NOWday = [NOWComp day];
    NSInteger NOWmonth = [NOWComp month];
    NSInteger NOWyear = [NOWComp year];
    NSInteger NOWhour = [NOWComp hour];
    
    NSDateFormatter * dateFormatter =[[NSDateFormatter alloc] init];
    if (year == NOWyear && month == NOWmonth) {
        if (day == NOWday) {
            dateFormatter.dateFormat = @"HH:mm";
        } else if (day == NOWday - 1) {
            dateFormatter.dateFormat = @"昨天";
        }
    } else {
        dateFormatter.dateFormat = @"M月d日";
    }
    
    NSString * ret = [dateFormatter stringFromDate:date];
    return ret;
}

@end
