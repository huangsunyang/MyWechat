//
//  MWChatTableViewCellReverse.m
//  MyWechat
//
//  Created by huangsunyang on 8/30/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import "MWChatTableViewCellReverse.h"

@implementation MWChatTableViewCellReverse

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) setDelegate:(id<MWMessageProtocol>)delegate {
    _delegate = delegate;
    
    UILongPressGestureRecognizer * longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self.delegate
                                                                             action:@selector(onMessageLongPressed:)];
    [self.messageBox addGestureRecognizer:longGesture];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
