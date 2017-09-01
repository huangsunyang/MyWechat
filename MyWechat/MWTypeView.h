//
//  MWTypeView.h
//  MyWechat
//
//  Created by huangsunyang on 8/30/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWTypeView : UIView<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *voiceOrTypeButton;
@property (weak, nonatomic) IBOutlet UITextView *textField;
@property (weak, nonatomic) IBOutlet UIButton *emojiButton;
@property (weak, nonatomic) IBOutlet UIButton *moreToolsButton;

@end
