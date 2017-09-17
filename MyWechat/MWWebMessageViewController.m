//
//  MWWebMessageViewController.m
//  MyWechat
//
//  Created by huangsunyang on 9/6/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import "MWWebMessageViewController.h"
#import "NJKWebViewProgressView.h"

@interface MWWebMessageViewController ()

@property (nonatomic, strong) NJKWebViewProgress * progressProxy;
@property (nonatomic, strong) NJKWebViewProgressView * progressView;
@property (nonatomic, strong) UIWebView * webView;

@end

@implementation MWWebMessageViewController

+ (instancetype) webViewWithURLString: (NSString *) urlStr {
    NSString * lowerCaseUrlStr = [urlStr lowercaseString];
    if (![lowerCaseUrlStr hasPrefix:@"http://"] && ![lowerCaseUrlStr hasPrefix:@"https://"]) {
        urlStr = [@"http://" stringByAppendingString:urlStr];
    }
    NSURL * url = [NSURL URLWithString:urlStr];
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
    _progressProxy = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    if (_URL) {
        NSURLRequest * req = [NSURLRequest requestWithURL:_URL];
        [self.webView loadRequest:req];
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_progressView removeFromSuperview];
}

- (void)loadView {
    self.webView = [[UIWebView alloc] init];
    self.webView.scalesPageToFit = YES;
    self.view = self.webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setURL:(NSURL *)URL {
    _URL = URL;
}

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [_progressView setProgress:progress animated:YES];
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

@end
