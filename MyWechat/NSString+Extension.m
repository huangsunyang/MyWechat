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
    NSDateFormatter * dateFormatter =[[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"M月d日 HH:mm";
    return [dateFormatter stringFromDate:date];
}

@end
