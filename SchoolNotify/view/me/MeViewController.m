//
//  MeViewController.m
//  SchoolNotify
//
//  Created by Jack on 22/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "MeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "NotificationsViewController.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"我", @"Me");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)logoutTouched:(id)sender {
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [app.loginViewController logout];
    
    UINavigationController *nvc = [app.tabBarController.viewControllers objectAtIndex:0];
    NotificationsViewController *n = [nvc.viewControllers objectAtIndex:0];
    n.navigationItem.rightBarButtonItem = nil;

}


@end
