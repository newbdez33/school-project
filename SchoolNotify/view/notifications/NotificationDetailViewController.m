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

@interface NotificationDetailViewController ()

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
