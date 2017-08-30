//
//  MWChatInfo.h
//  MyWechat
//
//  Created by huangsunyang on 8/30/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ChatMessageType) {
    ChatMessageTypeSend,
    ChatMessageTypeReceive,
    ChatMessageTypeSendInform,
};

@interface MWChatInfo : NSObject

@property (nonatomic, assign) ChatMessageType messageType;
@property (nonatomic, strong) NSDate * currentTime;

//send和recevie类型共有项
@property (nonatomic, copy) NSString * messageText;

//inform类型项目
@property (nonatomic, copy) NSString * informText;

- (instancetype) init;
- (instancetype) initWithType: (ChatMessageType) type string: (NSString *) string;

@end
