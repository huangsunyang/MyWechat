//
//  MWAddressBookManager.m
//  MyWechat
//
//  Created by huangsunyang on 9/2/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import "MWAddressBookManager.h"
#import "MWPersonInfo.h"

@interface MWAddressBookManager() {
    NSMutableArray * _addressBook;
    NSMutableDictionary * _addressBookInAlphabet;
}

@end

@implementation MWAddressBookManager

//单例模式，生成通讯录
+ (instancetype)sharedInstance {
    static MWAddressBookManager * infoManager = nil;
    if (infoManager) return infoManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        infoManager = [MWAddressBookManager alloc];
        infoManager = [infoManager initPrivate];
    });
    
    return infoManager;
}

//私有的构造函数
- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        static const NSString *kRandomAlphabet = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        int kRandomLength = 10;
        _addressBook = [[NSMutableArray alloc] init];
        _addressBookInAlphabet = [[NSMutableDictionary alloc] init];
        
        for (char ch = 'A'; ch <= 'Z' + 1; ch++) {
            NSNumber * key = [NSNumber numberWithChar:ch];
            [_addressBookInAlphabet setObject:[[NSMutableArray alloc] init] forKey:key];
        }
        
        for (int i = 0; i < 100; i++) {
            NSMutableString *randomString = [NSMutableString stringWithCapacity:kRandomLength];
            for (int i = 0; i < kRandomLength; i++) {
                [randomString appendFormat: @"%C", [kRandomAlphabet characterAtIndex:arc4random_uniform((u_int32_t)[kRandomAlphabet length])]];
            }
            
            MWPersonInfo * item = [[MWPersonInfo alloc] initWithName: randomString];
            char ch = [randomString characterAtIndex:0];
            ch = toupper(ch);
            
            //将通讯录中的对象按首字母分为26类
            if (ch >= 'A' && ch <= 'Z') {
                NSNumber * key = [NSNumber numberWithChar:ch];
                [_addressBookInAlphabet[key] addObject:item];
            } else {
                NSNumber * key = [NSNumber numberWithChar:'Z' + 1];
                [_addressBookInAlphabet[key] addObject:item];
            }
            
            [_addressBook addObject:item];
        }
        
        for (char ch = 'A'; ch <= 'Z' + 1; ch++) {
            NSNumber * key = [NSNumber numberWithChar:ch];
            [_addressBookInAlphabet[key] sortUsingComparator:
             ^ NSComparisonResult (MWPersonInfo * person_1, MWPersonInfo * person_2) {
                 NSString * str_1 = person_1.name;
                 NSString * str_2 = person_2.name;
                 NSLocale *locale=[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
                 NSRange range = NSMakeRange(0, str_1.length);
                 if (str_2.length < str_1.length) {
                     range = NSMakeRange(0, str_2.length);
                 }
                 NSComparisonResult result = [str_1 compare:str_2 options:NSCaseInsensitiveSearch range:range locale:locale];
                 return result;
             }];
        }
    }
    return self;
}

- (NSArray *) addressBook {
    return _addressBook;
}

- (NSDictionary *) addressBookInAlphabet {
    return _addressBookInAlphabet;
}

- (NSUInteger) numOfAlphabets {
    NSInteger ret = 0;
    for (char ch = 'A'; ch <= 'Z' + 1; ch++) {
        NSNumber * key = [NSNumber numberWithChar:ch];
        if (((NSMutableArray *)_addressBookInAlphabet[key]).count > 0) {
            ret++;
        }
    }
    return ret;
}

- (NSArray *) addressWithIndex: (NSUInteger) index {
    NSUInteger count = -1;
    for (char ch = 'A'; ch <= 'Z' + 1; ch++) {
        NSNumber * key = [NSNumber numberWithChar:ch];
        if (((NSMutableArray *)_addressBookInAlphabet[key]).count > 0) {
            if (++count == index) {
                return (NSMutableArray *)_addressBookInAlphabet[key];
            }
        }
    }
    return nil;
}

- (NSArray *) addressWithKey: (char) ch {
    NSNumber * key = [NSNumber numberWithChar:ch];
    return (NSArray *)_addressBookInAlphabet[key];
}

//从字母判断section
- (NSInteger) sectionWithCharacter: (char) ch {
    NSNumber * key = [NSNumber numberWithChar:ch];
    if (((NSArray *)_addressBookInAlphabet[key]).count == 0) {
        return -1;
    }
    
    NSInteger ret = 0;
    for (char c = 'A'; c <= 'Z' + 1; c++) {
        if (c == ch) return ret;
        key = [NSNumber numberWithChar:c];
        if (((NSArray *)_addressBookInAlphabet[key]).count > 0) {
            ret++;
        }
    }
    
    return -1;
}

//从section判断大写字母
- (char) charWithSection: (NSUInteger) section {
    NSInteger ret = 0;
    
    for (char c = 'A'; c <= 'Z' + 1; c++) {
        NSNumber * key = [NSNumber numberWithChar:c];
        if (((NSArray *)_addressBookInAlphabet[key]).count > 0) {
            if (ret == section) {
                if (c == 'Z' + 1) return '#';
                else return c;
            }
            ret++;
        }
    }
    
    return '?';
}


@end
