//
//  MWMainPageInfoManager.h
//  MyWechat
//
//  Created by huangsunyang on 7/23/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#ifndef MWMainPageInfoManager_h
#define MWMainPageInfoManager_h
#import <Foundation/Foundation.h>

#import "MWPersonInfo.h"

@interface MWMainPageInfoManager : NSObject

@property(nonatomic, strong) NSArray * allItems;

+ (instancetype) sharedInfo;
- (void) sortAllItems;

@end



#endif /* MWMainPageInfoManager_h */
