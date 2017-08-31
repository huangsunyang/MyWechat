//
//  MWChatInfo.m
//  MyWechat
//
//  Created by huangsunyang on 8/30/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import "MWMessage.h"

@implementation MWMessage

# pragma mark - init method

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self = [self initWithType:MessageTypeReceive string:@"测试字符串"];
    }
    
    return self;
}

- (instancetype) initWithType: (MessageType) type string: (NSString *) string {
    self = [super init];
    
    if (self) {
        self.messageType = type;
        
        if (type == MessageTypeSendInform) {
            self.informText = string;
        } else if (type == MessageTypeSend || type == MessageTypeReceive) {
            self.messageText = string;
        }
    }

    return self;
}

@end
