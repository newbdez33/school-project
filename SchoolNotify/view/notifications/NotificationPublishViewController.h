//
//  NotificationPublishViewController.h
//  SchoolNotify
//
//  Created by Jack on 6/09/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsViewController.h"

@interface NotificationPublishViewController : UIViewController <ContactsViewControllerPickerDelegate> {
    IBOutlet UITextField *contactCollectionFields;
    IBOutlet UIButton *notificationTypeButton;
    IBOutlet UISwitch *needReplySwitch;
    IBOutlet UITextView *contentTextView;
    
    NSArray *recipients;    //通知接收者s
}

@property (nonatomic, strong) NSDictionary *types;
@property (nonatomic, strong) NSString *selectedNotifyType;

- (IBAction)closeButtonTouched:(id)sender;
- (IBAction)presentContactPicker:(id)sender;
- (IBAction)notificationTypeButtonTouched:(id)sender;
- (IBAction)publishButtonTouched:(id)sender;

@end
