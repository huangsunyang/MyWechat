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
    self = [self initWithName:@"默认名字"];
    
    if (self) {
    }
    
    return self;
}

- (instancetype) initWithName: (NSString *) name {
    self = [self initWithName:name
                  lastMessage:@"最后一条消息"
              lastMessageTime:[NSDate dateWithTimeIntervalSinceNow:0]
                     isNotify:NO
            portraitImageName:@"default_portrait"];
    
    if (self) {
    }
    
    return self;
}

- (instancetype) initWithName: (NSString *) name
                  lastMessage: (NSString *) lastMessage
              lastMessageTime: (NSDate *) date
                     isNotify: (BOOL) isNotify
            portraitImageName: (NSString *) portraitName {
    self = [super init];
    if (self) {
        self.name = name;
        self.lastMessage = lastMessage;
        self.lastMessageTime = date;
        self.isNotify = isNotify;
        self.portrait = [UIImage imageNamed:portraitName];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.lastMessage forKey:@"lastMessage"];
    [coder encodeObject:self.lastMessageTime forKey:@"lastMessageTime"];
    [coder encodeBool:self.isNotify forKey:@"isNotify"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.lastMessage = [aDecoder decodeObjectForKey:@"lastMessage"];
    self.lastMessageTime = [aDecoder decodeObjectForKey:@"lastMessageTime"];
    self.isNotify = [aDecoder decodeBoolForKey:@"isNotify"];
    self.portrait = [UIImage imageNamed:@"default_portrait"];
    return self;
}

- (NSString *)description {
    return self.name;
}

@end
