//
//  MWMainPageTableViewCell.h
//  MyWechat
//
//  Created by huangsunyang on 7/25/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWMainPageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *portraitImageView;
@property (weak, nonatomic) IBOutlet UIImageView *notifyImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastMessageTimeLabel;

@end
