//
//  MWMainPageInfoManager.m
//  MyWechat
//
//  Created by huangsunyang on 7/23/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWMainPageInfoManager.h"
#import "MWMainPageItem.h"

@interface MWMainPageInfoManager () {
    NSMutableArray * _allItems;
}

@end

@implementation MWMainPageInfoManager

# pragma mark - init method
- (instancetype) init {
    @throw [[NSException alloc] initWithName:@"SingletonExceptrion"
                                      reason:@"Can not use init method of a singleton class"
                                    userInfo:nil];
}

- (instancetype) initPrivate {
    self = [super init];
    
    if (self) {
        for (int i = 0; i < 10; i++) {
            MWMainPageItem * item = [[MWMainPageItem alloc] init];
            [_allItems addObject:item];
        }
    }
    
    return self;
}

+ (instancetype) sharedInfo {
    static MWMainPageInfoManager * infoManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        infoManager = [[self alloc] initPrivate];
    });
    
    return infoManager;
}

#pragma mark - getter and setter

- (NSArray *) allItems {
    return _allItems;
}

@end
