//
//  MWAllUserMessageManager.h
//  MyWechat
//
//  Created by huangsunyang on 9/7/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWMessageManager.h"

@interface MWAllUserMessageManager : NSObject<NSCoding>

@property (strong, nonatomic) NSDictionary * allUserMessages;
+ (instancetype) sharedInstance;
- (NSMutableArray *) loadMessageWithUserName: (NSString *) name;
- (NSString *)itemArchievePathWithUserName:(NSString *) name;
@end
