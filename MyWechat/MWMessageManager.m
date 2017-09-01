//
//  MWMessageManager.m
//  MyWechat
//
//  Created by huangsunyang on 8/31/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import "MWMessageManager.h"

@interface MWMessageManager() {
    NSMutableArray * _allMessages;
}

@end

@implementation MWMessageManager

//单例模式
+ (instancetype) sharedInstance {
    static MWMessageManager * sharedInstance = nil;
    static dispatch_once_t pred;
    if (sharedInstance) return sharedInstance;
    
    dispatch_once(&pred, ^{
        sharedInstance = [MWMessageManager alloc];
        sharedInstance = [sharedInstance initPrivate];
    });
    
    return sharedInstance;
}

//私有的构造函数
- (instancetype)initPrivate {
    self = [super init];
    
    if (self) {
        _allMessages = [[NSMutableArray alloc] init];
        for (int i = 0; i < 5; i++) {
            MWMessage * message = [[MWMessage alloc] init];
            [_allMessages addObject:message];
        }
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
- (void) deleteMessageAtIndex: (long) index {
    [_allMessages removeObjectAtIndex:index];
}

@end
