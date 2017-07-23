//
//  MWMainPageItem.m
//  MyWechat
//
//  Created by huangsunyang on 7/23/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWMainPageItem.h"

@implementation MWMainPageItem

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.name = @"默认名字";
        self.lastMessage = @"最后一条消息";
        self.lastMessageTime = [NSDate dateWithTimeIntervalSinceNow:0];
        self.isNotify = NO;
    }
    
    return self;
}

- (NSString *)description {
    return self.name;
}

@end
