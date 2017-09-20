//
//  MWNetworkManager.m
//  MyWechat
//
//  Created by huangsunyang on 9/18/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import "MWNetworkManager.h"
#import "MWLog.h"
#import "MwnetworkData.pbobjc.h"

@interface MWNetworkManager()



@end

@implementation MWNetworkManager

+ (instancetype) sharedInstance {
    static MWNetworkManager * sharedInstance = nil;
    if (sharedInstance != nil) return sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [MWNetworkManager alloc];
        sharedInstance = [sharedInstance initPrivate];
    });
    
    return sharedInstance;
}


- (instancetype) initPrivate {
    self = [super init];
    if (self) {
        [self setupNetwork];
    }
    return self;
}


- (void) setupNetwork {
    NSString * localHost = @"127.0.0.1";
    int port = 4866;
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)(localHost), port, &readStream, &writeStream);
    
    self.inputStream = (__bridge NSInputStream *)readStream;
    self.outputStream = (__bridge NSOutputStream *)writeStream;
    
    self.inputStream.delegate = self;
    self.outputStream.delegate = self;
    
    [self.inputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [self.outputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    [self.inputStream open];
    [self.outputStream open];
}

- (void) receiveMessage {
    uint8_t buf[1024];
    NSMutableData * receiveDate = [[NSMutableData alloc] init];
    while ([self.inputStream hasBytesAvailable]) {
        NSInteger length = [self.inputStream read:buf maxLength:sizeof(buf)];
        [receiveDate appendBytes:buf length:length];
    }

    NSString * receiveStr = [[NSString alloc] initWithData:receiveDate encoding:NSUTF8StringEncoding];
    if (receiveStr.length <= 0) return;
    MWLog(@"%@", receiveStr);
    NSError * error;
    
    NSData * data = [receiveDate subdataWithRange:NSMakeRange(0, receiveStr.length)];
    
    MWNetworkData * networkData = [[MWNetworkData alloc] initWithData:data error:&error];
    
    MWLog(@"%@", networkData.description);
    [self dealWithNetworkData:networkData];
}

- (void) dealWithNetworkData: (MWNetworkData *) data {
    
}

- (void) closeConnection {
    [self.inputStream close];
    [self.outputStream close];
    
    [self.inputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [self.outputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
    NSString * event = @"nothing happened";
    switch (eventCode) {
        case NSStreamEventNone:
            event = @"NSStreamEventNone";
            break;
        case NSStreamEventOpenCompleted:
            event = @"NSStreamEventOpenCompleted";
            break;
        case NSStreamEventHasBytesAvailable: //有字节可读
            if (aStream == self.inputStream) {
                event = @"NSStreamEventHasBytesAvailable";
                if ([self.inputStream hasBytesAvailable]) {
                    [self receiveMessage];
                }
            }
            break;
        case NSStreamEventHasSpaceAvailable:
            event = @"NSStreamEventHasSpaceAvailable";
            break;
        case NSStreamEventErrorOccurred:
            event = @"NSStreamEventErrorOccurred";
            break;
        case NSStreamEventEndEncountered:   //结束
            event = @"NSStreamEventEndEncountered";
            [self closeConnection];
        default:
            break;
    }
    MWLog(@"event ---------- %@", event);
}



@end
