//
//  MWChatInfo.m
//  MyWechat
//
//  Created by huangsunyang on 8/30/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import "MWChatInfo.h"

@implementation MWChatInfo

# pragma mark - init method

- (instancetype) init {
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

- (instancetype) initWithType: (ChatMessageType) type string: (NSString *) string {
    self = [super init];
    
    if (self) {
        self.messageType = type;
        
        if (type == ChatMessageTypeSendInform) {
            self.informText = string;
        } else if (type == ChatMessageTypeSend || type == ChatMessageTypeReceive) {
            self.messageText = string;
        }
    }

    return self;
}

@end
