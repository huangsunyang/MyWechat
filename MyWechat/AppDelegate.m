//
//  AppDelegate.m
//  MyWechat
//
//  Created by huangsunyang on 7/23/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import "AppDelegate.h"
#import "MWMainPageInfoManager.h"
#import "MWMainPageTableViewController.h"
#import "MWAddressBookTableViewController.h"
#import "MWAddressBookManager.h"
#import "MWLog.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    //主界面
    MWMainPageTableViewController * mainPageTableViewController = [[MWMainPageTableViewController alloc] init];
    
    //navigation 微信聊天主界面
    UINavigationController * chatNaviController = [[UINavigationController alloc] initWithRootViewController:mainPageTableViewController];
    
    //通讯录界面
    MWAddressBookTableViewController * addressBookTableViewController = [[MWAddressBookTableViewController alloc] init];
    
    //navigation 通讯录界面
    UINavigationController * addressNaviController = [[UINavigationController alloc] initWithRootViewController:addressBookTableViewController];
    
    //tabbarController
    UITabBarController * tabBarController  = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[chatNaviController, addressNaviController];
    
    //添加tabBarItem 聊天
    chatNaviController.tabBarItem.title = @"聊天";
    chatNaviController.tabBarItem.image = [[UIImage imageNamed:@"chat_tabbar_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    chatNaviController.tabBarItem.selectedImage = [[UIImage imageNamed:@"chat_tabbar_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //添加tabBarItem 通讯录
    addressNaviController.tabBarItem.title = @"通讯录";
    addressNaviController.tabBarItem.image = [[UIImage imageNamed:@"addressBook_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    addressNaviController.tabBarItem.selectedImage = [[UIImage imageNamed:@"addressBook_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    self.window.rootViewController = tabBarController;
    self.window.backgroundColor = UIColor.whiteColor;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    BOOL success = [[MWAddressBookManager sharedInstance] saveChanges];
    if (success) {
        MWLog(@"Saved all addressbook items");
    } else {
        MWLog(@"Saved addressbook items failed");
    }
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    BOOL success = [[MWAddressBookManager sharedInstance] saveChanges];
    if (success) {
        MWLog(@"Saved all addressbook items");
    } else {
        MWLog(@"Saved addressbook items failed");
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
