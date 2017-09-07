//
//  MWAllUserMessageManager.m
//  MyWechat
//
//  Created by huangsunyang on 9/7/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import "MWAllUserMessageManager.h"

@interface MWAllUserMessageManager() {
    NSMutableDictionary * _allUserMessages;
}

@end

@implementation MWAllUserMessageManager

+ (instancetype) sharedInstance {
    static MWAllUserMessageManager * sharedInstance = nil;
    if (sharedInstance) return sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [MWAllUserMessageManager alloc];
        sharedInstance = [sharedInstance initPrivate];
    });
    
    return sharedInstance;
}


- (instancetype) initPrivate {
    self = [super init];
    
    if (self) {
        _allUserMessages = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (NSMutableArray *) loadMessageWithUserName: (NSString *) name {
    if (_allUserMessages[name] != nil) return _allUserMessages[name];
    
    NSString * path = [self itemArchievePathWithUserName:name];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        _allUserMessages[name] = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    } else {
        _allUserMessages[name] = [[NSMutableArray alloc] init];
    }
    
    return _allUserMessages[name];
}

- (NSString *)itemArchievePathWithUserName:(NSString *) name {
    NSArray * documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentDirectory = [documentDirectories firstObject];
    NSString * fileName = [name stringByAppendingString:@".archive"];
    return [documentDirectory stringByAppendingPathComponent: fileName];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.allUserMessages forKey:@"allUserMessages"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.allUserMessages = [aDecoder decodeObjectForKey:@"allUserMessages"];
    }
    return self;
}

@end
