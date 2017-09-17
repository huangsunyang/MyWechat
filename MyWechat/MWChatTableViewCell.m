//
//  MWChatTableViewCell.m
//  MyWechat
//
//  Created by NM on 2017/8/3.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import "MWChatTableViewCell.h"

@implementation MWChatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) setDelegate:(id<MWMessageProtocol>)delegate {
    _delegate = delegate;
    
    //长按显示复制、转发等选项
    UILongPressGestureRecognizer * longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self.delegate
                                                                             action:@selector(onMessageLongPressed:)];
    [self.messageBox addGestureRecognizer:longGesture];
    
    //头像点击跳转详细信息页面
    UITapGestureRecognizer * tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self.delegate
                                                                             action:@selector(onPortraitTapped:)];
    [self.leftPortrait addGestureRecognizer:tapGr];
    
    //信息点击显示连接跳转
    UITapGestureRecognizer * messageTapGr = [[UITapGestureRecognizer alloc] initWithTarget:self.delegate
                                                                             action:@selector(onMessageTapped:)];
    [self.messageBox addGestureRecognizer:messageTapGr];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) onDeleteMessage: (id) sender {
    
}

@end
