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
#import "MWMessageManager.h"
#import "MWMessage.h"
#import "MWChatSettingTableViewController.h"

@interface MWChatTableViewController ()

@property (nonatomic, strong) MWTypeView * typeView;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) BOOL isKeyboardShown;

@end

@implementation MWChatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    [self setupFrames];
    [self setupEvents];
    [self setupNavigationBarItems];
    
    self.isKeyboardShown = false;
}

- (void) setupViews {
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 200;
//    UILongPressGestureRecognizer *gest = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onMessageLongPressed:)];
//    [self.tableView addGestureRecognizer:gest];
    self.tableView.allowsSelection = NO;
    
    
    [self.view addSubview:self.tableView];
    
    UINib * nib = [UINib nibWithNibName:@"MWChatTableViewCell" bundle:nil];
    
    UINib * chatReverse = [UINib nibWithNibName:@"MWChatTableViewCellReverse" bundle:nil];
    
    UINib * informMessage = [UINib nibWithNibName:@"MWChatInformTableViewCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:@"MWChatTableViewCell"];
    
    [self.tableView registerNib:chatReverse forCellReuseIdentifier:@"MWChatTableViewCellReverse"];
    
    [self.tableView registerNib:informMessage forCellReuseIdentifier:@"MWChatInformTableViewCell"];
    
    
    
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"MWTypeView" owner:self options:nil];
    self.typeView = subviewArray[0];
    self.typeView.textField.delegate = self.typeView;
    [self.view addSubview:self.typeView];
}

- (void) setupFrames {
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50);
    
    self.typeView.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50);
}

- (void) setupEvents {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardFrameChanged:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(tableviewTouchInside)];
    [self.tableView addGestureRecognizer:tapGesture];
    [self.typeView.moreToolsButton addTarget:self
                                      action:@selector(onMoreToolsButtonClicked:)
                            forControlEvents:UIControlEventTouchUpInside];
}

- (void) setupNavigationBarItems {
    UIImage * image = [UIImage imageNamed:@"user_icon"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * setButton = [[UIBarButtonItem alloc] initWithImage:image
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(onRightNavigationBarItemClicked)];
    self.navigationItem.rightBarButtonItem = setButton;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self scollToLastCell];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    return [MWMessageManager sharedInstance].allMessages.count;
}

#pragma mark - Table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MWMessage * message = [MWMessageManager sharedInstance].allMessages[indexPath.row];
    
    if (message.messageType == MessageTypeReceive) {
        MWChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MWChatTableViewCell" forIndexPath:indexPath];
        cell.chatText.text = message.messageText;
        cell.delegate = self;
        return cell;
    } else if (message.messageType == MessageTypeSend) {
        MWChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MWChatTableViewCellReverse" forIndexPath:indexPath];
        cell.chatText.text = message.messageText;
        cell.delegate = self;
        return cell;
    } else if (message.messageType == MessageTypeSendInform) {
        MWChatInformTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MWChatInformTableViewCell" forIndexPath:indexPath];
        cell.informText.text = [NSString stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
        return cell;
    }
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


# pragma mark - keyboard events

- (void)keyboardWasShown:(NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    //Given size may not account for screen rotation
    int height = MIN(keyboardSize.height,keyboardSize.width);
    __unused int width = MAX(keyboardSize.height,keyboardSize.width);
    
    CGFloat wholeHeight = [[UIScreen mainScreen] bounds].size.height;
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width,
                                 wholeHeight - height);
    
    [UIView animateWithDuration:0.1
                     animations:^ {
                         [self setupFrames];
                     }];
    
    [self scollToLastCell];
}

- (void)keyboardWasHidden:(NSNotification *)notification {
    CGFloat wholeHeight = [[UIScreen mainScreen] bounds].size.height;
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width,
                                 wholeHeight);
    
    [UIView animateWithDuration:0.1
                     animations:^ {
                         [self setupFrames];
                     }];
    
    [self scollToLastCell];
}

- (void)keyboardFrameChanged: (NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    //Given size may not account for screen rotation
    int height = MIN(keyboardSize.height,keyboardSize.width);
    __unused int width = MAX(keyboardSize.height,keyboardSize.width);
    
    CGFloat wholeHeight = [[UIScreen mainScreen] bounds].size.height;
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width,
                                 wholeHeight - height);
    
    [UIView animateWithDuration:0.1
                     animations:^ {
                         [self setupFrames];
                     }];
    
    [self scollToLastCell];
}


# pragma mark - touch events

- (void) tableviewTouchInside {
    NSLog(@"tableview touch inside");
    [self.view endEditing:YES];
}

- (void) onRightNavigationBarItemClicked {
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"MWChatSettingTableViewController" bundle:nil];
    MWChatSettingTableViewController * chatSetting = [storyBoard instantiateViewControllerWithIdentifier:@"MWChatSettingTableViewController"];
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatSetting animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void) onMoreToolsButtonClicked:(id)sender {
    UIImage * image = [((UIButton *) sender) backgroundImageForState:UIControlStateNormal];
    
    if ([image isEqual: [UIImage imageNamed:@"add_icon"]]) {
        
    } else if ([image isEqual: [UIImage imageNamed:@"send_icon"]]) {
        NSString * text = self.typeView.textField.text;
        if (text.length > 0) {
            self.typeView.textField.text = @"";
            [self.typeView textViewDidChange:self.typeView.textField];
            [self sendMessage:text];
            [self scollToLastCell];
        }
    }
}

- (void) onMessageLongPressed: (UIGestureRecognizer *) gesture {
    NSLog(@"MessageLabel long pressed");
    CGPoint point = [gesture locationInView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    MWChatTableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    CGRect textRect = cell.chatText.frame;
    
    [self becomeFirstResponder];
    
    UIMenuController * menu = [UIMenuController sharedMenuController];
    UIMenuItem * deleteItem = [[UIMenuItem alloc] initWithTitle:@"删除"
                                                         action:@selector(onDeleteMessage:)];
    menu.menuItems = @[deleteItem];
    
    CGRect menuRect = CGRectMake(textRect.origin.x,
                                 cell.frame.origin.y + textRect.origin.y,
                                 textRect.size.width, textRect.size.height);
    
    [menu setTargetRect: menuRect inView:self.tableView];
    [menu setMenuVisible:YES animated:YES];
}

- (void)onDeleteMessage: (id)sender {
    
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

# pragma mark - tool functions

- (void) scollToLastCell {
    long numOfSection = [self.tableView numberOfSections];
    if (numOfSection <= 0) return;
    long numOfCell = [self tableView:self.tableView
               numberOfRowsInSection:numOfSection - 1];
    if (numOfCell <= 0) return;
    NSIndexPath * index = [NSIndexPath indexPathForRow:numOfCell - 1
                                             inSection:numOfSection - 1];
    
    [self.tableView scrollToRowAtIndexPath:index
                          atScrollPosition:UITableViewScrollPositionBottom
                                  animated:YES];
}

- (void) sendMessage: (NSString *) text {
    MWMessage * message = [[MWMessage alloc] initWithType:MessageTypeSend string:text];
    [[MWMessageManager sharedInstance] addMessage: message];
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
}

@end
