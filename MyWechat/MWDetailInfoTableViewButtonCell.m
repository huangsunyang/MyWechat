//
//  MWDetailInfoTableViewButtonCell.m
//  MyWechat
//
//  Created by huangsunyang on 9/5/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import "MWDetailInfoTableViewButtonCell.h"
#import "MWLog.h"

@implementation MWDetailInfoTableViewButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)sendMessageButtonClicked:(id)sender {
    MWLog(@"SendMessage ButtonClicked");
    if (self.buttonClickedBlock != nil) {
        self.buttonClickedBlock();
    }
}

@end
