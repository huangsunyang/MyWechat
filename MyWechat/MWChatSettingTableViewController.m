//
//  MWChatSettingTableViewController.m
//  MyWechat
//
//  Created by NM on 2017/9/1.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import "MWChatSettingTableViewController.h"
#import "MWMessageManager.h"

@interface MWChatSettingTableViewController ()

@end

@implementation MWChatSettingTableViewController

+ (instancetype) storyboardInstance {
    NSString * name = NSStringFromClass(self);
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:name bundle:nil];
    MWChatSettingTableViewController * chatSetting = [storyBoard instantiateViewControllerWithIdentifier:name];
    return chatSetting;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.scrollEnabled = NO;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (YES) {
        if (indexPath.section == 0) {
            
        } else if (indexPath.section == 1) {    //查找聊天记录
            
        } else if (indexPath.section == 2) {
            
        } else if (indexPath.section == 3) {    //设置聊天背景
            if (self.setBackgoundBlock) {
                [self setBackgoundBlock];
            }
        } else if (indexPath.section == 4) {    //清空聊天记录
            UIAlertController *alertController = [UIAlertController
                       alertControllerWithTitle:@""
                                        message:@"确定删除所有的聊天记录？"
                                        preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction =
            [UIAlertAction actionWithTitle:@"取消"
                                     style:UIAlertActionStyleCancel
                                   handler:nil];
            
            UIAlertAction *okAction =
            [UIAlertAction actionWithTitle:@"好的"
                                     style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       [[MWMessageManager sharedInstance] removeALLMessages];
                                   }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            
            //恢复cell的颜色，即取消selected状态
            UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.selected = NO;
            
            [self presentViewController:alertController animated:YES completion:nil];
        } else if (indexPath.section == 5) {    //投诉
            
        }
    }
}

@end
