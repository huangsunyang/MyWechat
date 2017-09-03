//
//  MWDetailInfoController.m
//  MyWechat
//
//  Created by huangsunyang on 9/3/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import "MWDetailInfoController.h"
#import "MWDetailInfoTableViewInfoCell.h"
#import "MWDetailInfoTableViewLabelCell.h"
#import "MWDetailInfoTableViewPhotoCell.h"

@interface MWDetailInfoController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *sendMessageButton;

@end

@implementation MWDetailInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void) setupView {
    UINib * nib = [UINib nibWithNibName:@"MWDetailInfoTableViewInfoCell" bundle:nil];
    [self.tableView registerNib:nib
         forCellReuseIdentifier:@"MWDetailInfoTableViewInfoCell"];
}

- (void) setupFrame {
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

#pragma mark - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MWDetailInfoTableViewInfoCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"MWDetailInfoTableViewInfoCell"];
        cell.nameLabel.text = @"asdfasdf";
        return cell;
    }
    return nil;
}


@end
