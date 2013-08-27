//
//  NotificationDetailViewController.h
//  SchoolNotify
//
//  Created by Jack on 27/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Notification;

@interface NotificationDetailViewController : UIViewController

@property (nonatomic, strong) Notification *notication;

- (IBAction)closeButtonTouched:(id)sender;

@end
