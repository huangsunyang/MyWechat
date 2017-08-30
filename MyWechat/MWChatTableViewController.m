//
//  MWChatTableViewController.m
//  MyWechat
//
//  Created by NM on 2017/8/3.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import "MWChatTableViewController.h"
#import "MWChatTableViewCell.h"
#import "NSString+NSStringExtension.h"
#import "MWChatInformTableViewCell.h"

@interface MWChatTableViewController ()

@end

@implementation MWChatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib * nib = [UINib nibWithNibName:@"MWChatTableViewCell" bundle:nil];
    
    UINib * chatReverse = [UINib nibWithNibName:@"MWChatTableViewCellReverse" bundle:nil];
    
    UINib * informMessage = [UINib nibWithNibName:@"MWChatInformTableViewCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"MWChatTableViewCell"];
    
    [self.tableView registerNib:chatReverse forCellReuseIdentifier:@"MWChatTableViewCellReverse"];
    
    [self.tableView registerNib:informMessage forCellReuseIdentifier:@"MWChatInformTableViewCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 200;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int sx = arc4random() % 30;
    if (sx < 15) {
        MWChatInformTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MWChatInformTableViewCell" forIndexPath:indexPath];
        cell.informText.text = [NSString stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
        return cell;
    }
    
    
    MWChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MWChatTableViewCellReverse" forIndexPath:indexPath];
    
    cell.leftPortrait.image = [UIImage imageNamed:@"default_portrait"];
    
    UIImage * image = [UIImage imageNamed:@"message_box_right"];

    
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(20, 40, 20, 40) resizingMode:UIImageResizingModeStretch];
    cell.messageBox.image = image;
    NSString * str = @"";
    
    int x = arc4random() % 30 + 1;
    for (int i = 0; i < x; i++) {
        str = [str stringByAppendingString:@"这是一条默认消息"];
    }
    
    cell.chatText.text = str;
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

@end
