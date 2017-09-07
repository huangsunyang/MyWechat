//
//  MWLog.h
//  MyWechat
//
//  Created by huangsunyang on 9/7/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//


#ifndef MWLog_h
#define MWLog_h

#define MWLog(str, args...) \
NSLog(@"%@%s %@", NSStringFromClass(self.class), __FUNCTION__,\
[NSString stringWithFormat:str, ##args])


#endif /* MWLog_h */
