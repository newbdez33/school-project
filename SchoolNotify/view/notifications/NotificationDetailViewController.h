//
//  NotificationDetailViewController.h
//  SchoolNotify
//
//  Created by Jack on 27/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Notification;

@interface NotificationDetailViewController : UIViewController<UITextFieldDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate> {
    
    UILabel *contentLabel;
    UIView *repliesView;
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UITextField *replyInput;
    IBOutlet UIButton *replyBtn;
    //用于键显示resize
    UIView *activeInputCtrl_;
    
}

@property (nonatomic, strong) Notification *notication;

- (IBAction)closeButtonTouched:(id)sender;
- (IBAction)replyButtonTouched:(id)sender;
@end
