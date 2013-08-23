//
//  AppDelegate.m
//  SchoolNotify
//
//  Created by Jack on 16/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "AppDelegate.h"
#import "TestFlight.h"

#import "NotificationsViewController.h"
#import "ContactsViewController.h"
#import "MeViewController.h"
#import "LoginViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //testflight
    [TestFlight takeOff:TESTFLIGHT_TOKEN];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    NotificationsViewController *notificationsViewController = [[NotificationsViewController alloc] initWithNibName:XIB(@"NotificationsViewController") bundle:nil];
    ContactsViewController *contactsViewController = [[ContactsViewController alloc] initWithNibName:XIB(@"ContactsViewController") bundle:nil];
    MeViewController *meViewController = [[MeViewController alloc] initWithNibName:XIB(@"MeViewController") bundle:nil];
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:notificationsViewController];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:contactsViewController];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:meViewController];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[nav1, nav2, nav3];
    
    
    //登陆初始化
    self.loginViewController = [[LoginViewController alloc] initWithNibName:XIB(@"LoginViewController") bundle:nil];
    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:self.loginViewController];
    mainNavigationController.navigationBarHidden = YES;
    
    //self.window.rootViewController = self.tabBarController;
    self.window.rootViewController = self.loginViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
