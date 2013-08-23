//
//  AppDelegate.h
//  SchoolNotify
//
//  Created by Jack on 16/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) LoginViewController *loginViewController;

@end
