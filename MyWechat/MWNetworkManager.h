//
//  MWNetworkManager.h
//  MyWechat
//
//  Created by huangsunyang on 9/18/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWNetworkManager : NSObject<NSStreamDelegate>

@property (nonatomic, strong) NSInputStream * inputStream;
@property (nonatomic, strong) NSOutputStream * outputStream;

+ (instancetype) sharedInstance;

@end
