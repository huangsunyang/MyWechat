//
//  MWMessageManager.h
//  MyWechat
//
//  Created by huangsunyang on 8/31/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWMessage.h"

@interface MWMessageManager : NSObject

@property (nonatomic, strong) NSArray * allMessages;

+ (instancetype) sharedInstance;
- (void) addMessage: (MWMessage *) message;
@end
