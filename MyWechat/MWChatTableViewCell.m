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
    
    UILongPressGestureRecognizer * longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self.delegate
                                                                             action:@selector(onMessageLongPressed:)];

    [self.chatText addGestureRecognizer:longGesture];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
