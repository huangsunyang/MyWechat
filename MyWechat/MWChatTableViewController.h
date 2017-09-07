//
//  MWChatTableViewController.h
//  MyWechat
//
//  Created by NM on 2017/8/3.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWMessageProtocol.h"
#import "MWPersonInfo.h"

@interface MWChatTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, MWMessageProtocol, NSStreamDelegate>

@property(nonatomic, strong) NSInputStream *inputStream;
@property(nonatomic, strong) NSOutputStream *outputStream;
@property(nonatomic, strong) MWPersonInfo * personInfo;

@end
