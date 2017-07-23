//
//  MWMainPageItem.h
//  MyWechat
//
//  Created by huangsunyang on 7/23/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#ifndef MWMainPageItem_h
#define MWMainPageItem_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MWMainPageItem : NSObject

@property(nonatomic, strong) NSString * name;
@property(nonatomic, strong) NSString * lastMessage;
@property(nonatomic, strong) NSDate * lastMessageTime;
@property(nonatomic, strong) UIImage * portrait;
@property(nonatomic) BOOL isNotify;

@end

#endif /* MWMainPageItem_h */
