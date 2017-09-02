//
//  MWMainPageInfoManager.m
//  MyWechat
//
//  Created by huangsunyang on 7/23/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWMainPageInfoManager.h"

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
        static const NSString *kRandomAlphabet = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        int kRandomLength = 10;
        _allItems = [[NSMutableArray alloc] init];
        for (int i = 0; i < 20; i++) {
            NSMutableString *randomString = [NSMutableString stringWithCapacity:kRandomLength];
            for (int i = 0; i < kRandomLength; i++) {
                [randomString appendFormat: @"%C", [kRandomAlphabet characterAtIndex:arc4random_uniform((u_int32_t)[kRandomAlphabet length])]];
            }
            MWPersonInfo * item = [[MWPersonInfo alloc] initWithName: randomString];
            [_allItems addObject:item];
        }
    }
    return self;
}

+ (instancetype) sharedInfo {
    static MWMainPageInfoManager * infoManager = nil;
    if (infoManager) return infoManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^ {
        infoManager = [[MWMainPageInfoManager alloc] initPrivate];
    });
    
    return infoManager;
}

#pragma mark - getter and setter

- (NSArray *) allItems {
    return _allItems;
}

@end
