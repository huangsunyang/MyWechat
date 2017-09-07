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
#import "MWNetworkData.pb.h"
#import "MWLog.h"
#import <err.h>
#import <errno.h>

@interface MWMainPageTableViewController ()

@property(nonatomic) MWMainPageInfoManager * infoManager;
@property(nonatomic, strong) NSInputStream *inputStream;
@property(nonatomic, strong) NSOutputStream *outputStream;

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    MWLog(@"main page view will appear");
    [self.tableView reloadData];
}

- (void) setupView {
    //导航栏
    self.navigationItem.title = @"微信";
    
    UINib * nib = [UINib nibWithNibName:@"MWMainPageTableViewCell" bundle:nil];
    
    [self.tableView registerNib:nib
         forCellReuseIdentifier:@"MWMainPageTableViewCell"];
}

- (void) setupNetwork {
    NSString * localHost = @"183.172.22.42";
    int port = 4867;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc {
    
}

- (void) closeConnection {
    [self.inputStream close];
    [self.outputStream close];
    //从主循环移除
    [self.inputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [self.outputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
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
    
    MWLog(@"%@", item);
    
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
    chatViewController.inputStream = self.inputStream;
    chatViewController.outputStream = self.outputStream;
    
    NSArray * items = [MWMainPageInfoManager sharedInfo].allItems;
    MWPersonInfo * item = items[indexPath.row];
    chatViewController.personInfo = item;
    
    [self.navigationController pushViewController:chatViewController animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


@end
