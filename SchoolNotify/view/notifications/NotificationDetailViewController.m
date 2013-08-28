//
//  NotificationDetailViewController.m
//  SchoolNotify
//
//  Created by Jack on 27/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "NotificationDetailViewController.h"
#import "AppDelegate.h"
#import "Notification.h"
#import "NotificationService.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.notication.addition = [NotificationService fetchNotificationAddition:self.notication];
    
    [self layoutContents];
}

- (void)layoutContents {
    
    //通知内容
    NSString *content = self.notication.content;
    if (content!=nil) {
        contentLabel.numberOfLines = 0;
        contentLabel.text = content;
        [contentLabel sizeToFit];
    }
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
        [replies enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            NSLog(@"next:%@", NSStringFromCGRect(nextPos));
            
            NSDictionary *reply = (NSDictionary *)obj;
            NSString *content = [reply objectForKey:API_KEY_NOTIFICATION_REPLIES_CONTENT];
            NSString *dt = [reply objectForKey:API_KEY_NOTIFICATION_REPLIES_DATETIME];
            
            CGRect replyPos = nextPos;
            UILabel *replyLabel = [[UILabel alloc] initWithFrame:replyPos];
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
        //
    }];
}

@end
