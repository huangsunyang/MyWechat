//
//  MWMessageManager.m
//  MyWechat
//
//  Created by huangsunyang on 8/31/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import "MWMessageManager.h"
#import "MWAllUserMessageManager.h"

@interface MWMessageManager() {
    __weak NSMutableArray * _allMessages;
}

@end

@implementation MWMessageManager

+ (instancetype) sharedInstanceWithUserName: (NSString *) name {
    MWMessageManager * sharedInstance = [MWMessageManager alloc];
    sharedInstance = [sharedInstance initWithUserName:name];
    return sharedInstance;
}

//私有的构造函数
- (instancetype)initWithUserName: (NSString *) name {
    self = [super init];
    
    if (self) {
        MWAllUserMessageManager * allMessageManager = [MWAllUserMessageManager sharedInstance];
        _allMessages = [allMessageManager loadMessageWithUserName:name];
        _usrName = name;
    }
    
    return self;
}

- (BOOL) saveToFile {
    MWAllUserMessageManager * allMessageManager = [MWAllUserMessageManager sharedInstance];
    NSString * path = [allMessageManager itemArchievePathWithUserName:self.usrName];
    return [NSKeyedArchiver archiveRootObject:_allMessages toFile:path];
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_allMessages forKey:@"allMessages"];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _allMessages = [coder decodeObjectForKey:@"allMessages"];
    }
    return self;
}


//所有的短信信息
- (NSArray *) allMessages {
    return _allMessages;
}

//插入信息
- (void) addMessage:(MWMessage *)message {
    [_allMessages addObject:message];
}

//在固定位置插入短信
- (void) addMessage:(MWMessage *)message AtIndex: (long) index {
    [_allMessages insertObject:message atIndex:index];
}

//删除某条短信
- (void) removeMessageAtIndex: (long) index {
    [_allMessages removeObjectAtIndex:index];
}

//删除全部短信
- (void)removeALLMessages {
    [_allMessages removeAllObjects];
}

@end
