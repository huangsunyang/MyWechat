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
    if (self.tableView == tableView) {
        //恢复cell的颜色，即取消selected状态
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selected = NO;
        
        if (indexPath.section == 0) {
            
        } else if (indexPath.section == 1) {    //查找聊天记录
            
        } else if (indexPath.section == 2) {
            
        } else if (indexPath.section == 3) {    //设置聊天背景
            [self showSetBackgroundAlertView];
        } else if (indexPath.section == 4) {    //清空聊天记录
            [self showRemoveAllMessageAlertView];
        } else if (indexPath.section == 5) {    //投诉
            
        }
    }
}

//显示是否删除所有聊天记录对话框
- (void) showRemoveAllMessageAlertView {
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
                               [[MWMessageManager sharedInstanceWithUserName:@""] removeALLMessages];
                           }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

//显示设施聊天背景图片选项
- (void) showSetBackgroundAlertView {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //从相册选择照片事件
    void (^choosePhotoFromAlbumBlock)(UIAlertAction * action) = ^(UIAlertAction * action) {
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:nil];
        } else {
            UIAlertController * unableToTakePhoto = [UIAlertController alertControllerWithTitle:nil
                                                                                        message:@"您的相册暂时无法使用"
                                                                                 preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
            [unableToTakePhoto addAction:action];
            [self presentViewController:unableToTakePhoto animated:YES completion:nil];
        }
    };
    
    UIAlertAction * chooseFromAlbum = [UIAlertAction actionWithTitle:@"从相册中选择"
                                                               style:UIAlertActionStyleDefault
                                                             handler:choosePhotoFromAlbumBlock];
    
    //拍照的事件
    void (^takePhotoBlock)(UIAlertAction * action) = ^(UIAlertAction * action) {
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:nil];
        } else {
            UIAlertController * unableToTakePhoto = [UIAlertController alertControllerWithTitle:nil
                                                                                        message:@"您的相机暂时无法使用"
                                                                                 preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
            [unableToTakePhoto addAction:action];
            [self presentViewController:unableToTakePhoto animated:YES completion:nil];
        }
    };
    
    UIAlertAction * takePhotoAction = [UIAlertAction actionWithTitle:@"拍一张"
                                                               style:UIAlertActionStyleDefault
                                                             handler:takePhotoBlock];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                            style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:chooseFromAlbum];
    [alertController addAction:takePhotoAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    //todo 
//    [MWMessageManager sharedInstance].backgroundImage = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
