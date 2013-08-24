//
//  LoginViewController.m
//  SchoolNotify
//
//  Created by Jack on 22/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "UserService.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
- (IBAction)loginTouched:(id)sender {
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.tabBarController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    app.tabBarController.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        User *user = [UserService login:username.text password:password.text];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (user) {
                app.currentUser = user;
                [self presentViewController:app.tabBarController animated:YES completion:^{
                    //
                }];
            }else {
                MBAlertView *alert = [MBAlertView alertWithBody:@"用户名或密码错误" cancelTitle:@"OK" cancelBlock:nil];
                [alert setBackgroundAlpha:0.8];
                [alert addToDisplayQueue];
            }

        });
    });
}

- (void)logout {
    [self dismissModalViewControllerAnimated:YES];
}

@end
