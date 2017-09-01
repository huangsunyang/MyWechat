//
//  MWTypeView.m
//  MyWechat
//
//  Created by huangsunyang on 8/30/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import "MWTypeView.h"

@implementation MWTypeView

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length == 0) {
        [self.moreToolsButton setBackgroundImage:[UIImage imageNamed:@"add_icon"]
                                        forState:UIControlStateNormal];
    } else {
        [self.moreToolsButton setBackgroundImage:[UIImage imageNamed:@"send_icon"]
                                        forState:UIControlStateNormal];
    }
}



@end
