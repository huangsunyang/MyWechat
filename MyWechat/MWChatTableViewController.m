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
    
    self.isKeyboardShown = false;
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
    self.typeView.textField.delegate = self;
    [self.view addSubview:self.typeView];
}

- (void) setupFrames {
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50);
    
    self.typeView.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50);
}

- (void) setupEvents {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasHidden:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(tableviewTouchInside)];
    [self.tableView addGestureRecognizer:tapGesture];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self scollToLastCell];
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MWMessage * message = [MWMessageManager sharedInstance].allMessages[indexPath.row];
    
    if (message.messageType == MessageTypeReceive) {
        MWChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MWChatTableViewCell" forIndexPath:indexPath];
        cell.chatText.text = message.messageText;
        return cell;
    } else if (message.messageType == MessageTypeSend) {
        MWChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MWChatTableViewCellReverse" forIndexPath:indexPath];
        cell.chatText.text = message.messageText;
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

- (void)keyboardWasShown:(NSNotification *)notification {
    if (self.isKeyboardShown) return;
    self.isKeyboardShown = YES;
    
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    //Given size may not account for screen rotation
    int height = MIN(keyboardSize.height,keyboardSize.width);
    __unused int width = MAX(keyboardSize.height,keyboardSize.width);
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - height);
    
    [UIView animateWithDuration:0.1
                     animations:^ {
                         [self setupFrames];
                     }];
    
    [self scollToLastCell];
}

- (void)keyboardWasHidden:(NSNotification *)notification {
    if (!self.isKeyboardShown) return;
    self.isKeyboardShown = NO;
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    //Given size may not account for screen rotation
    int height = MIN(keyboardSize.height,keyboardSize.width);
    __unused int width = MAX(keyboardSize.height,keyboardSize.width);
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + height);
    
    [UIView animateWithDuration:0.1
                     animations:^ {
                         [self setupFrames];
                     }];
    
    [self scollToLastCell];
}

# pragma mark - textField delegate

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView == self.typeView.textField) {
        if (self.typeView.textField.text.length > 0) {
            NSString * text = self.typeView.textField.text;
            [self sendMessage:text];
            [self.typeView.textField setText:@""];
        }
        [self scollToLastCell];
    }
}

# pragma mark - touch
- (void) tableviewTouchInside {
    [self.view endEditing:YES];
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
}

@end
