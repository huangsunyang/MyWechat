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
#import "MWTypeView.h"

@interface MWChatTableViewController ()

@property (nonatomic, strong) MWTypeView * typeView;
@property (nonatomic, strong) UITableView * tableView;

@end

@implementation MWChatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    [self setupFrames];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void) setupViews {
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    UINib * nib = [UINib nibWithNibName:@"MWChatTableViewCell" bundle:nil];
    
    UINib * chatReverse = [UINib nibWithNibName:@"MWChatTableViewCellReverse" bundle:nil];
    
    UINib * informMessage = [UINib nibWithNibName:@"MWChatInformTableViewCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"MWChatTableViewCell"];
    
    [self.tableView registerNib:chatReverse forCellReuseIdentifier:@"MWChatTableViewCellReverse"];
    
    [self.tableView registerNib:informMessage forCellReuseIdentifier:@"MWChatInformTableViewCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 200;
    
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"MWTypeView" owner:self options:nil];
    self.typeView = subviewArray[0];
    [self.view addSubview:self.typeView];
}

- (void) setupFrames {
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50);
    
    self.typeView.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50);
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

- (void)keyboardWasShown:(NSNotification *)notification
{
    
    // Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    //Given size may not account for screen rotation
    int height = MIN(keyboardSize.height,keyboardSize.width);
    int width = MAX(keyboardSize.height,keyboardSize.width);
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - height);
    
    [self setupFrames];
}

@end
