//
//  MWWebMessageViewController.h
//  MyWechat
//
//  Created by huangsunyang on 9/6/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import "ViewController.h"
#import "NJKWebViewProgress.h"

@interface MWWebMessageViewController : ViewController<NJKWebViewProgressDelegate, UIWebViewDelegate>

@property (nonatomic) NSURL * URL;

+ (instancetype) webViewWithURLString: (NSString *) str;
+ (instancetype) webViewWithURL: (NSURL *) url;
@end
