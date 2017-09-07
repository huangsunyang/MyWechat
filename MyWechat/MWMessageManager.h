//
//  MWMessageManager.h
//  MyWechat
//
//  Created by huangsunyang on 8/31/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MWMessage.h"

@interface MWMessageManager : NSObject

@property (nonatomic, strong) NSString * usrName;
@property (nonatomic, weak) NSArray * allMessages;
@property (nonatomic, strong) UIImage * backgroundImage;

+ (instancetype) sharedInstanceWithUserName: (NSString *) name;
- (void) addMessage: (MWMessage *) message;
- (void) addMessage:(MWMessage *)message AtIndex: (long) index;
- (void) removeMessageAtIndex: (long) index;
- (void) removeALLMessages;
- (BOOL) saveToFile;
@end
