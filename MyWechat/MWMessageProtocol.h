//
//  MWMessageProtocol.h
//  MyWechat
//
//  Created by NM on 2017/9/1.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MWMessageProtocol <NSObject>
- (void) onMessageLongPressed: (UIGestureRecognizer *) gesture;
- (void) onPortraitTapped: (UIGestureRecognizer *) gesture;
- (void)onMessageTapped: (UIGestureRecognizer *) gesture;
@end
