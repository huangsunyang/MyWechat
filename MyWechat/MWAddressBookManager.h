//
//  MWAddressBookManager.h
//  MyWechat
//
//  Created by huangsunyang on 9/2/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MWAddressBookManager : NSObject

@property (nonatomic, strong) NSArray * addressBook;
@property (nonatomic, strong) NSDictionary * addressBookInAlphabet;

+ (instancetype)sharedInstance;
- (NSUInteger) numOfAlphabets;
- (NSArray *) addressWithIndex: (NSUInteger) index;
- (NSArray *) addressWithKey: (char) ch;
- (NSInteger) sectionWithCharacter: (char) ch;
- (char) charWithSection: (NSUInteger) section;

@end