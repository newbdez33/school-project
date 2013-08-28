//
//  NotificationDetailViewController.m
//  SchoolNotify
//
//  Created by Jack on 27/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "NotificationDetailViewController.h"
#import "NotificationsViewController.h"
#import "AppDelegate.h"
#import "Notification.h"
#import "NotificationService.h"
#import "MBProgressHUD.h"

#define MARGIN_BOTTOM 10;

@interface NotificationDetailViewController () {
    CGRect nextPos;
}

@end

@implementation NotificationDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"通知详细内容", @"");
    }
    return self;
}

- (void)replyButtonTouched:(id)sender {
    
    NSString *reply = replyInput.text;
    if(reply==nil || [reply isEqualToString:@""]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", @"")  message:NSLocalizedString(@"请输入回复内容", @"")  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        
        [replyInput becomeFirstResponder];
        return;
    }
    
    [replyInput resignFirstResponder];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        BOOL success = [NotificationService postReply:self.notication content:reply];
        
        if (success) {
            self.notication.addition = [NotificationService fetchNotificationAddition:self.notication];   
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success) {
                //刷新reply页
                replyInput.text = @"";
                [self layoutContents];
            }else {
                //失败提示
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", @"")  message:NSLocalizedString(@"服务器处理回复失败，请稍后重试。", @"")  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alertView show];
            }
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        });
    });

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwasShown:) name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwasHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    self.notication.addition = [NotificationService fetchNotificationAddition:self.notication];
    
    [self layoutContents];
}

- (void)layoutContents {
    
    [scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //通知内容
    CGRect startPos = CGRectMake(20, 20, 280, 26);
    contentLabel = [[UILabel alloc] initWithFrame:startPos];
    contentLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
    contentLabel.textColor = [UIColor blackColor];
    NSString *content = self.notication.content;
    if (content!=nil) {
        contentLabel.numberOfLines = 0;
        contentLabel.text = content;
        [contentLabel sizeToFit];
        [scrollView addSubview:contentLabel];
    }
    CGRect fix = contentLabel.frame;
    fix.size.width = startPos.size.width;
    contentLabel.frame = fix;
    nextPos = contentLabel.frame;
    nextPos.origin.y = contentLabel.frame.origin.y + contentLabel.frame.size.height;
    nextPos.origin.y += MARGIN_BOTTOM;
    
    //署名及日期
    NSString *publisher = self.notication.publisher_name;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:nextPos];
    if (publisher!=nil) {
        nameLabel.textColor = [UIColor grayColor];
        [nameLabel setFont:contentLabel.font];
        [scrollView addSubview:nameLabel];
        nameLabel.text = publisher;
    }
    
    NSString *datetime = self.notication.datetime;
    UILabel *datetimeLabel = [[UILabel alloc] initWithFrame:nextPos];
    if (datetime!=nil) {
        datetimeLabel.textColor = [UIColor grayColor];
        datetimeLabel.backgroundColor = [UIColor clearColor];
        [datetimeLabel setTextAlignment:NSTextAlignmentRight];
        [datetimeLabel setFont:contentLabel.font];
        [scrollView addSubview:datetimeLabel];
        datetimeLabel.text = datetime;
        
        nextPos = datetimeLabel.frame;
        nextPos.origin.y = datetimeLabel.frame.origin.y + datetimeLabel.frame.size.height;
        nextPos.origin.y += MARGIN_BOTTOM;
    }
    
    //考试成绩
    NSArray *scores = self.notication.addition.scores;
    if (scores!=nil && scores.count>0) {
        
        //标题
        UILabel *scoreTitleLabel = [[UILabel alloc] initWithFrame:nextPos];
        scoreTitleLabel.textColor = [UIColor grayColor];
        scoreTitleLabel.backgroundColor = [UIColor clearColor];
        [scoreTitleLabel setFont:contentLabel.font];
        [scrollView addSubview:scoreTitleLabel];
        scoreTitleLabel.text = NSLocalizedString(@"考试成绩", @"");
        
        //线
        nextPos = scoreTitleLabel.frame;
        nextPos.origin.y = scoreTitleLabel.frame.origin.y + scoreTitleLabel.frame.size.height;
        nextPos.origin.y += 5;
        nextPos.size.height = 2;    //线宽
        UIView *solidLine = [[UIView alloc] initWithFrame:nextPos];
        solidLine.backgroundColor = [UIColor blackColor];
        
        [scrollView addSubview:solidLine];
        
        nextPos.origin.y = solidLine.frame.origin.y + solidLine.frame.size.height;
        
        //分数
        [scores enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSLog(@"next:%@", NSStringFromCGRect(nextPos));
            
            NSDictionary *pair = (NSDictionary *)obj;
            NSString *subject = [pair objectForKey:API_KEY_NOTIFICATION_SCORES_KEY];
            NSString *score = [pair objectForKey:API_KEY_NOTIFICATION_SCORES_VALUE];
            
            CGRect namePos = nextPos;
            UILabel *subjectLabel = [[UILabel alloc] initWithFrame:namePos];
            [subjectLabel setFont:contentLabel.font];
            subjectLabel.text = subject;
            [subjectLabel sizeToFit];
            [scrollView addSubview:subjectLabel];
            
            CGRect scorePos = nextPos;
            scorePos.origin.x = 200;
            UILabel *scoreLabel = [[UILabel alloc] initWithFrame:scorePos];
            [scoreLabel setFont:contentLabel.font];
            scoreLabel.text = score;
            [scoreLabel sizeToFit];
            [scrollView addSubview:scoreLabel];
            
            nextPos.origin.y = subjectLabel.frame.origin.y + subjectLabel.frame.size.height + 5;
        }];
        
    }
    
    //回复
    NSArray *replies = self.notication.addition.replies;
    if (replies!=nil && replies.count>0) {
        
        self.notication.need_reply = API_KEY_NOTIFICATION_NEED_REPLY_DID_REPLY;
        
        //线
        nextPos.size.height = 2;    //线宽
        UIView *solidLine = [[UIView alloc] initWithFrame:nextPos];
        solidLine.backgroundColor = [UIColor blackColor];
        
        [scrollView addSubview:solidLine];
        
        nextPos.origin.y = solidLine.frame.origin.y + solidLine.frame.size.height + MARGIN_BOTTOM;
        
        //标题
        UILabel *replyTitleLabel = [[UILabel alloc] initWithFrame:nextPos];
        replyTitleLabel.textColor = [UIColor grayColor];
        replyTitleLabel.backgroundColor = [UIColor clearColor];
        [replyTitleLabel setFont:contentLabel.font];
        [scrollView addSubview:replyTitleLabel];
        replyTitleLabel.text = NSLocalizedString(@"回复内容", @"");
        [replyTitleLabel sizeToFit];
        
        nextPos.origin.y = replyTitleLabel.frame.origin.y + replyTitleLabel.frame.size.height + MARGIN_BOTTOM;
        
        
        //回复
        repliesView.frame = nextPos;
        [replies enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSDictionary *reply = (NSDictionary *)obj;
            NSString *content = [reply objectForKey:API_KEY_NOTIFICATION_REPLIES_CONTENT];
            NSString *dt = [reply objectForKey:API_KEY_NOTIFICATION_REPLIES_DATETIME];
            
            CGRect replyPos = nextPos;
            UILabel *replyLabel = [[UILabel alloc] initWithFrame:replyPos];
            replyLabel.numberOfLines = 0;
            [replyLabel setFont:contentLabel.font];
            replyLabel.text = [NSString stringWithFormat:NSLocalizedString(@"回复：%@", @""), content];
            [replyLabel sizeToFit];
            [scrollView addSubview:replyLabel];
            
            nextPos.origin.y = replyLabel.frame.origin.y + replyLabel.frame.size.height + 5;
            nextPos.size.height = replyLabel.frame.size.height;
            
            CGRect dtPos = nextPos;
            UILabel *dtLabel = [[UILabel alloc] initWithFrame:dtPos];
            [dtLabel setFont:contentLabel.font];
            dtLabel.textColor = [UIColor grayColor];
            dtLabel.text = dt;
            dtPos = dtLabel.frame;
            dtPos.size.width = contentLabel.frame.size.width;
            dtLabel.textAlignment = NSTextAlignmentRight;
            [scrollView addSubview:dtLabel];
            
            nextPos.origin.y = dtLabel.frame.origin.y + dtLabel.frame.size.height + 5;
        }];

    }
    
    nextPos.origin.y += MARGIN_BOTTOM;
    
    if (![self.notication.need_reply isEqualToString:API_KEY_NOTIFICATION_NEED_REPLY_NO_NEED_REPLY]) {
        CGRect textFieldPos = nextPos;
        textFieldPos.size.width = 220;
        textFieldPos.size.height = 30;
        replyInput.frame = textFieldPos;
        [scrollView addSubview:replyInput];
        
        CGRect replyBtnPos = textFieldPos;
        replyBtnPos.origin.x = textFieldPos.origin.x +textFieldPos.size.width + 2;
        replyBtnPos.size.width = 50;
        replyBtn.frame = replyBtnPos;
        replyBtn.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:12];
        [replyBtn setTitle:NSLocalizedString(@"回复" , @"") forState:UIControlStateNormal];
        [replyBtn addTarget:self action:@selector(replyButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:replyBtn];

    }else {
        replyInput.hidden = YES;
        replyBtn.hidden = YES;
    }
    
    
    
    nextPos.origin.y = replyInput.frame.origin.y + replyInput.frame.size.height + MARGIN_BOTTOM;
    
    
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, nextPos.origin.y)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeButtonTouched:(id)sender {
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.tabBarController dismissViewControllerAnimated:YES completion:^{
        if ([self.notication.need_reply isEqualToString:API_KEY_NOTIFICATION_NEED_REPLY_DID_REPLY]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_NAME_NOTIFICATION_UPDATED object:self userInfo:self.notication.originData];
        }

    }];
}

#pragma mark UITextField Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	activeInputCtrl_ = textField;
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField*)textField {
	activeInputCtrl_ = nil;
    return YES;
}


#pragma mark - Keyboard show/hide
- (void)keyboardwasShown:(NSNotification *)notif {
    
    NSDictionary *w_info = [notif userInfo];
	NSValue *w_aValue = [w_info objectForKey:UIKeyboardFrameEndUserInfoKey];
	CGSize w_keyboardSize = [w_aValue CGRectValue].size;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= w_keyboardSize.height;
    
    
    CGRect activeRect = activeInputCtrl_.frame;
    
    CGRect ctrlFrame = [activeInputCtrl_.superview convertRect:activeRect toView:self.view];
    
    if (!CGRectContainsPoint(aRect, CGPointMake(ctrlFrame.origin.x, ctrlFrame.origin.y + ctrlFrame.size.height)) ) {
        int offset = ctrlFrame.origin.y + ctrlFrame.size.height - aRect.size.height + 20;
        
        CGPoint scrollPoint = CGPointMake(0.0, scrollView.contentOffset.y + offset);
        [scrollView setContentOffset:scrollPoint animated:YES];
        [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, scrollView.contentSize.height + offset)];
    }
    
    
}
// 隐藏键盘
- (void)keyboardwasHidden:(NSNotification *)notif {
    //
}


@end
