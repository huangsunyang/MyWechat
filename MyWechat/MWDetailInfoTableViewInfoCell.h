//
//  MWDetailInfoTableViewInfoCell.h
//  MyWechat
//
//  Created by huangsunyang on 9/3/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWDetailInfoTableViewInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView * portrait;
@property (weak, nonatomic) IBOutlet UILabel * nameLabel;
@property (weak, nonatomic) IBOutlet UILabel * wechatCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel * nickNameLabel;
@end
