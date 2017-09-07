//
//  MWWebMessageViewController.m
//  MyWechat
//
//  Created by huangsunyang on 9/6/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import "MWWebMessageViewController.h"

@interface MWWebMessageViewController ()

@end

@implementation MWWebMessageViewController

+ (instancetype) webViewWithURLString: (NSString *) str {
    NSURL * url = [NSURL URLWithString:str];
    return [MWWebMessageViewController webViewWithURL:url];
}

+ (instancetype) webViewWithURL: (NSURL *) url {
    MWWebMessageViewController * webView = [[MWWebMessageViewController alloc] init];
    webView.URL = url;
    return webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadView {
    UIWebView * webView = [[UIWebView alloc] init];
    webView.scalesPageToFit = YES;
    self.view = webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setURL:(NSURL *)URL {
    _URL = URL;
    if (_URL) {
        NSURLRequest * req = [NSURLRequest requestWithURL:_URL];
        [(UIWebView *)self.view loadRequest:req];
    }
}

@end
