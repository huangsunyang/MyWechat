//
//  MWDetailInfoController.m
//  MyWechat
//
//  Created by huangsunyang on 9/3/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import "MWAllExtension.h"
#import "MWDetailInfoController.h"
#import "MWDetailInfoTableViewInfoCell.h"
#import "MWDetailInfoTableViewLabelCell.h"
#import "MWDetailInfoTableViewPhotoCell.h"
#import "MWDetailInfoTableViewButtonCell.h"

@interface MWDetailInfoController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MWDetailInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupFrame];
}

- (void) setupView {
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    UINib * infoCellNib = [UINib nibWithNibName:@"MWDetailInfoTableViewInfoCell" bundle:nil];
    [self.tableView registerNib:infoCellNib
         forCellReuseIdentifier:@"MWDetailInfoTableViewInfoCell"];
    
    UINib * labelCellNib = [UINib nibWithNibName:@"MWDetailInfoTableViewLabelCell" bundle:nil];
    [self.tableView registerNib:labelCellNib
         forCellReuseIdentifier:@"MWDetailInfoTableViewLabelCell"];
    
    UINib * photoCellNib = [UINib nibWithNibName:@"MWDetailInfoTableViewPhotoCell" bundle:nil];
    [self.tableView registerNib:photoCellNib
         forCellReuseIdentifier:@"MWDetailInfoTableViewPhotoCell"];
    
    UINib * buttonCellNib = [UINib nibWithNibName:@"MWDetailInfoTableViewButtonCell" bundle:nil];
    [self.tableView registerNib:buttonCellNib
         forCellReuseIdentifier:@"MWDetailInfoTableViewButtonCell"];
    
}

- (void) setupFrame {
    CGSize fullScreenSize = [UIScreen mainScreen].bounds.size;
    self.view.frame = CGRectMake(0, 0, fullScreenSize.width, fullScreenSize.height);
    self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 1;
        case 1: return 2;
        case 2: return 4;
        default: return 1;
    }
}

#pragma mark - tableView delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: return 80;
        case 1: return 40;
        case 2:
            switch (indexPath.row) {
                case 1: return 70;
                case 3: return 50;
                default: return 40;
            }
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 18;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MWDetailInfoTableViewInfoCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"MWDetailInfoTableViewInfoCell"];
        cell.nameLabel.text = @"asdfasdf";
        return cell;
    } else if (indexPath.section == 1) {
        MWDetailInfoTableViewLabelCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"MWDetailInfoTableViewLabelCell"];
        if (indexPath.row == 0) {
            cell.itemNameLabel.text = @"电话号码";
            cell.itemValueLabel.text = @"+8613482251730";
            return cell;
        } else if (indexPath.row == 1) {
            cell.itemNameLabel.text = @"标签";
            cell.itemValueLabel.text = @"默认标签";
            return cell;
        }
    } else if (indexPath.section == 2) {
        MWDetailInfoTableViewLabelCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"MWDetailInfoTableViewLabelCell"];
        if (indexPath.row == 0) {
            cell.itemNameLabel.text = @"地区";
            cell.itemValueLabel.text = @"背景海淀";
            return cell;
        } else if (indexPath.row == 2) {
            cell.itemNameLabel.text = @"更多";
            cell.itemValueLabel.text = @"";
            return cell;
        } else if (indexPath.row == 1) {
            MWDetailInfoTableViewPhotoCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"MWDetailInfoTableViewPhotoCell"];
            return cell;
        } else if (indexPath.row == 3) {
            MWDetailInfoTableViewButtonCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"MWDetailInfoTableViewButtonCell"];
            return cell;
        }
    }
    
    return nil;
}


@end
