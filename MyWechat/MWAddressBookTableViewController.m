//
//  MWAddressBookTableViewController.m
//  MyWechat
//
//  Created by huangsunyang on 9/2/2017.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import "MWAddressBookTableViewController.h"
#import "MWAddressBookManager.h"
#import "MWAlphabetTableViewCell.h"
#import "MWAddressBookHeaderView.h"
#import "MWAddressBookTableViewCell.h"
#import "AddressBookFooterView.h"
#import "MWPersonInfo.h"
#import "ALToastView.h"
#import "MWDetailInfoController.h"
#import "MWLog.h"

@interface MWAddressBookTableViewController ()

@property (strong, nonatomic) UITableView * addressBookTableView;
@property (strong, nonatomic) UITableView * alphabeticTableView;
@property (strong, nonatomic) UIPanGestureRecognizer * alphabeticPanGesture;
@property (strong, nonatomic) UILongPressGestureRecognizer * alphabeticTapGesture;

@end

@implementation MWAddressBookTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self setupFrame];
    [self setupEvents];
}

- (void) setupViews {
    self.addressBookTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.addressBookTableView.dataSource = self;
    self.addressBookTableView.delegate = self;
    //隐藏滚动条
    self.addressBookTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.addressBookTableView];
    
    UINib * addressTableViewNib = [UINib nibWithNibName:@"MWAddressBookTableViewCell" bundle:nil];
    [self.addressBookTableView registerNib:addressTableViewNib forCellReuseIdentifier:@"MWAddressBookTableViewCell"];
    
    self.alphabeticTableView = [[UITableView alloc] init];
    self.alphabeticTableView.dataSource = self;
    self.alphabeticTableView.delegate = self;
    self.alphabeticTableView.scrollEnabled = NO;
    //取消cell的点击事件
    self.alphabeticTableView.allowsSelection = NO;
    //隐藏分割线
    self.alphabeticTableView.separatorColor = [UIColor clearColor];
    self.alphabeticTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.alphabeticTableView];
    
    UINib * alphaticNib = [UINib nibWithNibName:@"MWAlphabetTableViewCell" bundle:nil];
    [self.alphabeticTableView registerNib:alphaticNib forCellReuseIdentifier:@"MWAlphabetTableViewCell"];
}

- (void) setupFrame {
    self.addressBookTableView.frame = CGRectMake(0, 0,
                                                 self.view.frame.size.width,
                                                 self.view.frame.size.height);
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat navigationBarHeight = self.navigationController.navigationBar.bounds.size.height;
    CGFloat tabbarHeight = self.tabBarController.tabBar.bounds.size.height;
    CGFloat alphabeticHeight = screenHeight - navigationBarHeight - tabbarHeight - statusBarHeight;
    
    CGFloat alphabeticWidth = 20;
    
    self.alphabeticTableView.frame = CGRectMake(self.view.frame.size.width - alphabeticWidth,
                                                navigationBarHeight + statusBarHeight,
                                                alphabeticWidth,
                                                alphabeticHeight);
}

- (void) setupEvents {
    self.alphabeticPanGesture = [[UIPanGestureRecognizer alloc] init];
    [self.alphabeticPanGesture addTarget:self action:@selector(alphabeticTableViewWasPanned:)];
    self.alphabeticPanGesture.delegate = self;
    [self.alphabeticTableView addGestureRecognizer:self.alphabeticPanGesture];
    
    self.alphabeticTapGesture = [[UILongPressGestureRecognizer alloc] init];
    [self.alphabeticTapGesture addTarget:self action:@selector(alphabeticTableViewWasTapped:)];
    self.alphabeticTapGesture.delegate = self;
    self.alphabeticTapGesture.minimumPressDuration = 0.1;
    [self.alphabeticTableView addGestureRecognizer:self.alphabeticTapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.alphabeticTableView) {
        return 1;
    } else {
        return [[MWAddressBookManager sharedInstance] numOfAlphabets];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.alphabeticTableView) {
        return 27;
    } else {
        NSArray * partArray = [[MWAddressBookManager sharedInstance] addressWithSection:section];
        return partArray.count;
    }
}

# pragma mark - tableView delegate

//高度，右侧字母列表高度整体高度固定，总体平分
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.alphabeticTableView) {
        return self.alphabeticTableView.frame.size.height / 27;
    } else {
        return 50;
    }
}

//获取cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.alphabeticTableView) {
        MWAlphabetTableViewCell * cell = [self.alphabeticTableView dequeueReusableCellWithIdentifier:@"MWAlphabetTableViewCell"];
        char ch = 'A' + indexPath.row;
        if (ch == '[') ch = '#';
        cell.alphabetLabel.text = [NSString stringWithFormat:@"%C", (unichar)ch];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    } else {
        NSArray * partArray = [[MWAddressBookManager sharedInstance] addressWithSection:indexPath.section];
        
        MWAddressBookTableViewCell * cell = [self.addressBookTableView dequeueReusableCellWithIdentifier:@"MWAddressBookTableViewCell"];
        
        cell.nameLabel.text = ((MWPersonInfo *)partArray[indexPath.row]).name;
        return cell;
    }
}

//header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.addressBookTableView) {
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"MWAddressBookHeaderView" owner:self options:nil];
        MWAddressBookHeaderView * view = subviewArray[0];
        char ch = [[MWAddressBookManager sharedInstance] charWithSection:section];
        view.textLabel.text = [NSString stringWithFormat:@"%c", ch];
        return view;
    }
    return nil;
}

//footer
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (tableView == self.addressBookTableView) {
        if (section == [self.addressBookTableView numberOfSections] - 1) {
            NSArray * viewArray = [[NSBundle mainBundle] loadNibNamed:@"AddressBookFooterView"
                                                                owner:self
                                                              options:nil];
            AddressBookFooterView * view = viewArray[0];
            NSInteger count = [[MWAddressBookManager sharedInstance] addressBook].count;
            view.textLabel.text = [NSString stringWithFormat:@"%lu位联系人", count];
            return view;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.addressBookTableView) {
        return 15;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    //groupStyle的tableView自带footer，且不接受高度为0
    //所以需要将高度设置为CGFLOAT_MIN
    if (tableView == self.addressBookTableView) {
        if (section == [self.addressBookTableView numberOfSections] - 1) {
            return 50;
        }
        return CGFLOAT_MIN;
    } else {
        return CGFLOAT_MIN;
    }
}

//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.alphabeticTableView) {
        //获取点击的cell中的字母
        MWAlphabetTableViewCell * cell = [self.alphabeticTableView cellForRowAtIndexPath:indexPath];
        char ch = [cell.alphabetLabel.text characterAtIndex:0];
        if (ch == '#') ch = 'Z' + 1;
        
        //获取字母对应的通讯录的section
        NSArray * addresses = [[MWAddressBookManager sharedInstance] addressWithKey:ch];
        
        //如果存在对应的通讯录成员，则跳转，否则不发生跳转
        if (addresses.count > 0) {
            NSUInteger section = [[MWAddressBookManager sharedInstance] sectionWithCharacter:ch];
            NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:section];
            [self.addressBookTableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    } else if (tableView == self.addressBookTableView) {
        self.hidesBottomBarWhenPushed = YES;
        MWDetailInfoController * detailInfoController = [[MWDetailInfoController alloc] init];
        MWPersonInfo * info = [[MWAddressBookManager sharedInstance] addressWithIndex:indexPath];
        detailInfoController.personInfo = info;
        [self.navigationController pushViewController:detailInfoController animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}

#pragma mark - gesture delegate

// 当有多个手势的时候需要实现，目前不需要
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer == self.alphabeticTapGesture) {
        return YES;
    }
    return YES;
}

#pragma mark - events

- (void) alphabeticTableViewWasPanned: (UIPanGestureRecognizer *) gr {
    if (gr.state == UIGestureRecognizerStateBegan || gr.state == UIGestureRecognizerStateChanged) {
        self.alphabeticTableView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        CGPoint point = [gr locationInView:self.alphabeticTableView];
        MWLog(@"%f %f", point.x, point.y);
        if (point.x < 0) {
            [ALToastView removeToastView];
            self.alphabeticTableView.backgroundColor = [UIColor clearColor];
            //神来之笔
            [self.alphabeticTableView resignFirstResponder];
            return;
        }
        NSIndexPath * index = [self.alphabeticTableView indexPathForRowAtPoint: point];
        MWAlphabetTableViewCell * cell = [self.alphabeticTableView cellForRowAtIndexPath:index];
        [ALToastView toastInView:self.view withText:cell.alphabetLabel.text];
        [self.view layoutIfNeeded];
        [self tableView:self.alphabeticTableView didSelectRowAtIndexPath:index];
    } else {
        [ALToastView removeToastView];
        self.alphabeticTableView.backgroundColor = [UIColor clearColor];
    }
}

- (void) alphabeticTableViewWasTapped: (UILongPressGestureRecognizer *) gr {
    if (gr.state != UIGestureRecognizerStateEnded) {
        self.alphabeticTableView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
        NSIndexPath * index = [self.alphabeticTableView indexPathForRowAtPoint: [gr locationInView:self.alphabeticTableView]];
        MWAlphabetTableViewCell * cell = [self.alphabeticTableView cellForRowAtIndexPath:index];
        [ALToastView toastInView:self.view withText:cell.alphabetLabel.text];
        [self.view layoutIfNeeded];
        [self tableView:self.alphabeticTableView didSelectRowAtIndexPath:index];
    } else if (gr.state == UIGestureRecognizerStateEnded) {
        [ALToastView removeToastView];
        self.alphabeticTableView.backgroundColor = [UIColor clearColor];
    }
}



@end
