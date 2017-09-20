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
#import "MWNetworkManager.h"
#import "MWNetworkData.pb.h"
#import "MWLog.h"
#import "MWAllExtension.h"
#import <sys/socket.h>
#import <netdb.h>
#import <err.h>
#import <errno.h>

@interface MWMainPageTableViewController ()

@property(nonatomic) MWMainPageInfoManager * infoManager;
@property(nonatomic, weak) NSOutputStream *outputStream;

@end

@implementation MWMainPageTableViewController

# pragma mark - view life cycle

- (instancetype) init {
    self = [super initWithStyle:UITableViewStylePlain];
    
    return self;
}

- (void)viewDidLoad {
    MWLog(@"main page view did load");
    [super viewDidLoad];
    
    [self setupView];
    [self setupNetwork];
}

- (void) reload {
    [[MWMainPageInfoManager sharedInfo] sortAllItems];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    MWLog(@"main page view will appear");
    [self reload];
}

- (void) setupView {
    //导航栏
    self.navigationItem.title = @"微信";
    
    UINib * nib = [UINib nibWithNibName:@"MWMainPageTableViewCell" bundle:nil];
    
    [self.tableView registerNib:nib
         forCellReuseIdentifier:@"MWMainPageTableViewCell"];
}

- (void) setupNetwork {
    self.outputStream = [MWNetworkManager sharedInstance].outputStream;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc {
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


#pragma mark - Table view delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [MWMainPageInfoManager sharedInfo].allItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MWMainPageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MWMainPageTableViewCell"
                              forIndexPath:indexPath];
    
    NSArray * items = [MWMainPageInfoManager sharedInfo].allItems;
    MWPersonInfo * item = items[indexPath.row];
    
    cell.nameLabel.text = item.name;
    cell.lastMessageLabel.text = item.lastMessage;
    cell.portraitImageView.image = item.portrait;
    cell.lastMessageTimeLabel.text = [NSString stringFromDate:item.lastMessageTime];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.hidesBottomBarWhenPushed = YES;
    MWChatTableViewController * chatViewController = [[MWChatTableViewController alloc] init];
    
    NSArray * items = [MWMainPageInfoManager sharedInfo].allItems;
    MWPersonInfo * item = items[indexPath.row];
    chatViewController.personInfo = item;
    
    [self.navigationController pushViewController:chatViewController animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

@end
