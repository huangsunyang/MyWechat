//
//  MWDetailInfoController.h
//  MyWechat
//
//  Created by huangsunyang on 9/3/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MWPersonInfo;

@interface MWDetailInfoController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) MWPersonInfo * personInfo;
@end
