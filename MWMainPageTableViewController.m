//
//  MWMainPageTableViewController.m
//  MyWechat
//
//  Created by huangsunyang on 7/23/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//
#import "MWMainPageTableViewCell.h"
#import "MWMainPageTableViewController.h"
#import "MWMainPageInfoManager.h"
#import "MWChatTableViewController.h"
#import <sys/socket.h>
#import <netdb.h>

@interface MWMainPageTableViewController ()

@property(nonatomic) MWMainPageInfoManager * infoManager;

@end

@implementation MWMainPageTableViewController

- (instancetype) init {
    self = [super initWithStyle:UITableViewStylePlain];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self setupNetwork];
}

- (void) setupView {
    //导航栏
    self.navigationItem.title = @"微信";
    
    UINib * nib = [UINib nibWithNibName:@"MWMainPageTableViewCell" bundle:nil];
    
    [self.tableView registerNib:nib
         forCellReuseIdentifier:@"MWMainPageTableViewCell"];
}

- (void) setupNetwork {
    NSString * localHost = @"127.0.0.1";
    int port = 486;
    int socketFileDescriptor = socket(AF_INET, SOCK_STREAM, 0);
    
    if (socketFileDescriptor == -1) {
        NSLog(@"Failed to create socket.");
        return;
    }
    
    struct hostent * romoteHostEnd;
    
    
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
    return [MWMainPageInfoManager sharedInfo].allItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MWMainPageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MWMainPageTableViewCell"
                              forIndexPath:indexPath];
    
    NSArray * items = [MWMainPageInfoManager sharedInfo].allItems;
    
    MWPersonInfo * item = items[indexPath.row];
    
    NSLog(@"%@", item);
    
    cell.nameLabel.text = item.name;
    cell.lastMessageLabel.text = item.lastMessage;
    cell.portraitImageView.image = item.portrait;
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.hidesBottomBarWhenPushed = YES;
    MWChatTableViewController * chatViewController = [[MWChatTableViewController alloc] init];
    [self.navigationController pushViewController:chatViewController animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


@end
