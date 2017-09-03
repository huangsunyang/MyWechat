//
//  MWChatSettingTableViewController.h
//  MyWechat
//
//  Created by NM on 2017/9/1.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SetBackgroundBlock)(void);
typedef void (^ClearAllMessageBlock)(void);

@interface MWChatSettingTableViewController : UITableViewController

@property (copy, nonatomic) SetBackgroundBlock setBackgoundBlock;
@property (copy, nonatomic) ClearAllMessageBlock clearAllMessageBlock;

+ (instancetype) storyboardInstance;
@end
