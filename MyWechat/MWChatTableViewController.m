//
//  MWChatTableViewController.m
//  MyWechat
//
//  Created by NM on 2017/8/3.
//  Copyright © 2017年 huangsunyang. All rights reserved.
//

#import "MWChatTableViewController.h"
#import "MWChatTableViewCell.h"
#import "NSString+Extension.h"
#import "MWChatInformTableViewCell.h"
#import "MWTypeView.h"
#import "MWMessageManager.h"
#import "MWMessage.h"
#import "MWChatSettingTableViewController.h"
#import "MWDetailInfoController.h"
#import "MWWebMessageViewController.h"
#import <sys/socket.h>
#import <netdb.h>
#import "MWNetworkData.pb.h"
#import <err.h>
#import <errno.h>
#import "YYText.h"
#import "MWLog.h"

@interface MWChatTableViewController ()

@property (nonatomic, strong) MWTypeView * typeView;
@property (nonatomic, strong) UIImageView * backgroundView;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) BOOL isKeyboardShown;

@property (nonatomic, strong) NSIndexPath * currentLongPressedIndex;

@end

@implementation MWChatTableViewController

- (void)viewDidLoad {
    MWLog(@"chat view did load");
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
    self.tableView.allowsSelection = NO;
    //设置tableview透明，才能够动态改变背后的背景
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    
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
    
    self.view.backgroundColor = [UIColor whiteColor];
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(menuWasHidden:)
                                                 name:UIMenuControllerDidHideMenuNotification
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

- (void) viewWillAppear:(BOOL)animated {
    MWLog(@"chat view will appear");
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    //todo
//    if ([MWMessageManager sharedInstance].backgroundImage != nil) {
//        self.view.backgroundColor = [UIColor colorWithPatternImage:[MWMessageManager sharedInstance].backgroundImage];
//    } else {
//        self.view.backgroundColor = [UIColor whiteColor];
//    }
}


- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self scollToLastCell];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[MWMessageManager sharedInstanceWithUserName:self.personInfo.name] saveToFile];
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
    NSString * name = self.personInfo.name;
    return [MWMessageManager sharedInstanceWithUserName:name].allMessages.count;
}

#pragma mark - Table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * name = self.personInfo.name;
    MWMessage * message = [MWMessageManager sharedInstanceWithUserName:name].allMessages[indexPath.row];
    
    if (message.messageType == MessageTypeReceive) {
        MWChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MWChatTableViewCell" forIndexPath:indexPath];
        cell.chatText.text = message.messageText;
        cell.delegate = self;
        return cell;
    } else if (message.messageType == MessageTypeSend) {
        MWChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MWChatTableViewCellReverse" forIndexPath:indexPath];
        //cell.chatText.text = message.messageText;
        NSString * wholeText = message.messageText;
        NSError * error;
        NSDataDetector *dataDetector=[NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
        NSArray *arrayOfAllMatches=[dataDetector matchesInString:wholeText options:NSMatchingReportProgress range:NSMakeRange(0, wholeText.length)];

        NSMutableAttributedString * text = [[NSMutableAttributedString alloc] initWithString:wholeText];
        for (NSTextCheckingResult *match in arrayOfAllMatches) {
            [text yy_setTextHighlightRange:match.range//设置点击的位置
                                     color:[UIColor orangeColor]
                           backgroundColor:[UIColor whiteColor]
                                 tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
                                     MWLog(@"这里是点击事件");
                                     //跳转用的WKWebView
                                     MWWebMessageViewController *webView = [MWWebMessageViewController webViewWithURLString:[wholeText substringWithRange:match.range]];
                                     self.hidesBottomBarWhenPushed = YES;
                                     [self.navigationController pushViewController:webView animated:YES];
                                     
            }];
        }
        cell.chatText.attributedText = text;
        cell.delegate = self;
        return cell;
    } else if (message.messageType == MessageTypeSendInform) {
        MWChatInformTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MWChatInformTableViewCell" forIndexPath:indexPath];
        cell.informText.text = [NSString stringFromDate:[NSDate date]];
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

- (void) menuWasHidden: (NSNotification *)notification {
    [UIMenuController sharedMenuController].menuItems = nil;
    [[UIMenuController sharedMenuController] update];
}

# pragma mark - touch events

- (void) tableviewTouchInside {
    MWLog(@"tableview touch inside");
    [self.view endEditing:YES];
}

- (void) onRightNavigationBarItemClicked {
    MWChatSettingTableViewController * chatSetting = [MWChatSettingTableViewController storyboardInstance];
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatSetting animated:YES];
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
    if (gesture.state == UIGestureRecognizerStateBegan) {
        MWLog(@"MessageLabel long pressed");
        CGPoint point = [gesture locationInView:self.tableView];
        
        [self becomeFirstResponder];
        
        //获取当前点击的indexPath
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
        MWChatTableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        //回调的方法需要此参数
        self.currentLongPressedIndex = indexPath;
        
        //文字部分的frame
        CGRect textRect = cell.chatText.frame;
        
        UIMenuController * menu = [UIMenuController sharedMenuController];
        UIMenuItem * deleteItem = [[UIMenuItem alloc] initWithTitle:@"删除"
                                                             action:@selector(onDeleteMessage:)];
        UIMenuItem * copyItem = [[UIMenuItem alloc] initWithTitle:@"复制"
                                                           action:@selector(onCopyMessage:)];
        UIMenuItem * forwardItem = [[UIMenuItem alloc] initWithTitle:@"转发"
                                                           action:@selector(onForwardMessage:)];
        UIMenuItem * moreItem = [[UIMenuItem alloc] initWithTitle:@"更多"
                                                           action:@selector(onMoreItem:)];
        menu.menuItems = @[copyItem, deleteItem, forwardItem, moreItem];
        
        //显示位置为menuRect上下边的中点
        CGRect menuRect = CGRectMake(textRect.origin.x,
                                     cell.frame.origin.y + textRect.origin.y,
                                     textRect.size.width, textRect.size.height);
        
        [menu setTargetRect: menuRect inView:self.tableView];
        [menu setMenuVisible:YES animated:YES];
    }
}

- (void) onPortraitTapped: (UITapGestureRecognizer *) gr {
    MWLog(@"portrain tapped");
    self.hidesBottomBarWhenPushed = YES;
    MWDetailInfoController * detailInfoController = [[MWDetailInfoController alloc] init];
    detailInfoController.personInfo = self.personInfo;
    [self.navigationController pushViewController:detailInfoController animated:YES];
}

- (void) onMessageTapped:(UIGestureRecognizer *)gesture {
    self.hidesBottomBarWhenPushed = YES;
    
    //获取当前点击的indexPath
    CGPoint point = [gesture locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    MWChatTableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    //获取所有的链接
    NSString * wholeText = cell.chatText.text;
    NSError * error;
    NSDataDetector *dataDetector=[NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
    NSArray *arrayOfAllMatches=[dataDetector matchesInString:wholeText options:NSMatchingReportProgress range:NSMakeRange(0, wholeText.length)];
    
    //只有一个url就直接打开连接
    if (arrayOfAllMatches.count == 1) {
        NSTextCheckingResult * match = arrayOfAllMatches[0];
        NSString * urlStr = [wholeText substringWithRange:match.range];
        MWWebMessageViewController * webView = [MWWebMessageViewController webViewWithURLString: urlStr];
        [self.navigationController pushViewController:webView animated:YES];
        return;
    }
    
    //显示alertview
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@""
                                                                              message:@""
                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSTextCheckingResult * match in arrayOfAllMatches) {
        UIAlertAction * action = [UIAlertAction actionWithTitle:[wholeText substringWithRange:match.range]
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {
                                                            MWWebMessageViewController * webView = [MWWebMessageViewController webViewWithURLString:[wholeText substringWithRange:match.range]];
                                                            [self.navigationController pushViewController:webView animated:YES];
                                                        }];
        [alertController addAction:action];
    }
    
    [self presentViewController:alertController animated:YES completion:nil];
}

//删除一条信息
- (void)onDeleteMessage: (id)sender {
    NSString * name = self.personInfo.name;
    MWMessageManager * messageManager = [MWMessageManager sharedInstanceWithUserName:name];
    [messageManager removeMessageAtIndex:self.currentLongPressedIndex.row];
    [self.tableView reloadData];
}

//复制选中字符串到剪贴板
- (void)onCopyMessage: (id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    MWChatTableViewCell * cell = [self.tableView cellForRowAtIndexPath:self.currentLongPressedIndex];
    pasteboard.string = cell.chatText.text;
}

- (void)onMoreItem: (id)sender {
    
}

- (void)onForwardMessage: (id)sender {
    
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

# pragma mark - tool functions
- (void) addMessage: (MWMessage *) message {
    NSString * name = self.personInfo.name;
    [[MWMessageManager sharedInstanceWithUserName:name] addMessage: message];
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
    [self scollToLastCell];
}

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
    
    [self addMessage:message];
    
    //记录当下的最后一条消息和发送时间
    self.personInfo.lastMessage = message.messageText;
    self.personInfo.lastMessageTime = [NSDate date];
    
    //尝试发送protobuf
    if ([self.outputStream hasSpaceAvailable]) {
        MWNetworkDataBuilder * proto = [[MWNetworkDataBuilder alloc] init];
        [proto setType:1];
        [proto setFromUsr:@"huangsunyang"];
        [proto setToUsr:@"choufei"];
        [proto setStrData:text];
        MWNetworkData * networkData = [proto build];
        [self.outputStream write:[networkData data].bytes maxLength:[networkData data].length];
    }
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode {
    NSString * event = @"nothing happened";
    switch (eventCode) {
        case NSStreamEventNone:
            event = @"NSStreamEventNone";
            break;
        case NSStreamEventOpenCompleted:
            event = @"NSStreamEventOpenCompleted";
            break;
        case NSStreamEventHasBytesAvailable: //有字节可读
            if (aStream == self.inputStream) {
                event = @"NSStreamEventHasBytesAvailable";
                if ([self.inputStream hasBytesAvailable])
                    [self receiveMessage];
            }
            break;
        case NSStreamEventHasSpaceAvailable:
            event = @"NSStreamEventHasSpaceAvailable";
            break;
        case NSStreamEventErrorOccurred:
            event = @"NSStreamEventErrorOccurred";
            break;
        case NSStreamEventEndEncountered:   //结束
            event = @"NSStreamEventEndEncountered";
            [self closeConnection];
        default:
            break;
    }
    MWLog(@"event ---------- %@", event);
}

- (void) receiveMessage {
    uint8_t buf[1024];
    NSMutableData * receiveDate = [[NSMutableData alloc] init];
    while ([self.inputStream hasBytesAvailable]) {
        NSInteger length = [self.inputStream read:buf maxLength:sizeof(buf)];
        [receiveDate appendBytes:buf length:length];
    }
    NSString * receiveStr = [[NSString alloc] initWithData:receiveDate encoding:NSUTF8StringEncoding];
    if (receiveStr.length <= 0) return;
    MWMessage * message = [[MWMessage alloc] initWithType:MessageTypeReceive string:receiveStr];
    [self addMessage:message];
}

- (void) closeConnection {
    [self.inputStream close];
    [self.outputStream close];
    //从主循环移除
    [self.inputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [self.outputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

@end
