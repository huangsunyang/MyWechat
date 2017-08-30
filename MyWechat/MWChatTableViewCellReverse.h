//
//  MWChatTableViewCellReverse.h
//  MyWechat
//
//  Created by huangsunyang on 8/30/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWChatTableViewCellReverse : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *leftPortrait;
@property (strong, nonatomic) IBOutlet UIImageView *messageBox;
@property (weak, nonatomic) IBOutlet UILabel *chatText;

@end
