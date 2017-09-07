//
//  MWMainPageInfoManager.m
//  MyWechat
//
//  Created by huangsunyang on 7/23/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWMainPageInfoManager.h"
#import "MWAddressBookManager.h"

@interface MWMainPageInfoManager () {
    NSMutableArray * _allItems;
}

@end

@implementation MWMainPageInfoManager

# pragma mark - init method
- (instancetype) init {
    @throw [[NSException alloc] initWithName:@"SingletonException"
                                      reason:@"Can not use init method of a singleton class"
                                    userInfo:nil];
}

- (instancetype) initPrivate {
    self = [super init];
    
    if (self) {
        MWAddressBookManager * addressBookManager = [MWAddressBookManager sharedInstance];
        NSArray * allAddress = addressBookManager.addressBook;
        _allItems = [[NSMutableArray alloc] init];
        for (int i = 0; i < allAddress.count; i++) {
            __weak MWPersonInfo * item = allAddress[i];
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
