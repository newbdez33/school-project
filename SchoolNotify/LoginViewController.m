//
//  LoginViewController.m
//  SchoolNotify
//
//  Created by Jack on 22/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

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
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDelegate.tabBarController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    appDelegate.tabBarController.modalPresentationStyle = UIModalPresentationCurrentContext;
    if (YES) {
        [self presentViewController:appDelegate.tabBarController animated:YES completion:^{
            //
        }];
        return;
    }
}

- (void)logout {
    [self dismissModalViewControllerAnimated:YES];
}

@end
