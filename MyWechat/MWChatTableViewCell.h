//
//  MWChatTableViewCell.h
//  MyWechat
//
//  Created by NM on 2017/8/3.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWMessageProtocol.h"
#import "YYLabel.h"

@interface MWChatTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *leftPortrait;
@property (strong, nonatomic) IBOutlet UIImageView *messageBox;
@property (strong, nonatomic) IBOutlet UILabel *chatText;
@property (weak, nonatomic) id<MWMessageProtocol> delegate;

@end
