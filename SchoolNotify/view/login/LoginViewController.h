//
//  LoginViewController.h
//  SchoolNotify
//
//  Created by Jack on 22/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController {
    IBOutlet UITextField *username;
    IBOutlet UITextField *password;
}

- (IBAction)loginTouched:(id)sender;
- (void)logout;

@end
