//
//  MWMainPageItem.m
//  MyWechat
//
//  Created by huangsunyang on 7/23/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWPersonInfo.h"

@implementation MWPersonInfo

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.name = @"默认名字";
        self.lastMessage = @"最后一条消息";
        self.lastMessageTime = [NSDate dateWithTimeIntervalSinceNow:0];
        self.isNotify = NO;
        self.portrait = [UIImage imageNamed:@"default_portrait"];
    }
    
    return self;
}

- (instancetype) initWithName: (NSString *) name {
    self = [super init];
    
    if (self) {
        self = [self init];
        self.name = name;
    }
    
    return self;
}

- (NSString *)description {
    return self.name;
}

@end
