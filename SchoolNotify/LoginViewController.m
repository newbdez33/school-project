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
#import "MBProgressHUD.h"

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
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSError *err = nil;
        User *user = [UserService login:username.text password:password.text error:&err];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (err!=nil) {
                
                NSMutableString *error_str = [NSMutableString string];
                [err.userInfo enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    NSString *errormsg = (NSString *)obj;
                    [error_str appendFormat:@"%@\n", errormsg];
                }];
                
                MBAlertView *alert = [MBAlertView alertWithBody:error_str cancelTitle:@"OK" cancelBlock:nil];
                [alert setBackgroundAlpha:0.8];
                [alert addToDisplayQueue];
                
            }else {
                if (user) {
                    app.currentUser = user;
                    [self presentViewController:app.tabBarController animated:YES completion:^{
                        //
                    }];
                }
            }
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        });
    });
}

- (void)logout {
    [self dismissModalViewControllerAnimated:YES];
}

@end
