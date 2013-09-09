//
//  NotificationPublishViewController.m
//  SchoolNotify
//
//  Created by Jack on 6/09/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "NotificationPublishViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "Contact.h"
#import "NotificationsTypePickerViewController.h"
#import "MLTableAlert.h"
#import "NotificationService.h"
#import "NotificationsViewController.h"

#define HEIGHT_TEXTVIEW 160

@interface NotificationPublishViewController () {
    MLTableAlert *typeAlert;
}

@end

@implementation NotificationPublishViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.types = @{@"通知":@"1", @"紧急通知":@"2", @"系统通知":@"3"};
        self.selectedNotifyType = @"1";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwasShown:) name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwasHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [[contentTextView layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[contentTextView layer] setBorderWidth:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions!
- (IBAction)publishButtonTouched:(id)sender {
    
    [contentTextView resignFirstResponder];
    
    NSString *need_reply = @"0";
    if (needReplySwitch.on == YES) {
        need_reply = @"1";
    }
    
    NSMutableString *error_msg = [NSMutableString string];
    if (contactCollectionFields.text.length==0) {
        [error_msg appendFormat:@"%@\n", @"请选择联系人"];
    }
    if (contentTextView.text.length==0) {
        [error_msg appendFormat:@"%@\n", @"请输入通知内容"];
    }
    if (error_msg.length>0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", @"")  message:NSLocalizedString(error_msg, @"")  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    BOOL success = [NotificationService postNotification:self.selectedNotifyType need_reply:need_reply content:contentTextView.text recipients:recipients];
    if (success) {
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [app.tabBarController dismissViewControllerAnimated:YES completion:^{
            UINavigationController *nvc = [app.tabBarController.viewControllers objectAtIndex:0];
            NotificationsViewController *n = [nvc.viewControllers objectAtIndex:0];
            [n loadData];
        }];

    }else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", @"")  message:NSLocalizedString(@"发布通知时出错，请确认网络连接稍后重试", @"")  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)presentContactPicker:(id)sender {
    ContactsViewController *contactsPicker = [[ContactsViewController alloc] initWithNibName:XIB(@"ContactsViewController") bundle:nil];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:contactsPicker];
    
    [self presentViewController:nav animated:YES completion:^{
        contactsPicker.delegate = self;
        [contactsPicker modeForContactsPicker];
    }];
}

- (void)doneWithPickingContacts:(NSArray *)contacts {
    
    recipients = [NSArray arrayWithArray:contacts];
    NSMutableString *recipients_string = [NSMutableString stringWithFormat:@""];
    [recipients enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Contact *c = obj;
        [recipients_string appendFormat:@"%@ ", c.name];
    }];
    contactCollectionFields.text = recipients_string;
    
    //TODO Maybe use this https://github.com/bennyguitar/iOS----BubbleButtonView
    
    [self dismissViewControllerAnimated:YES completion:^{
    
        
    }];
}

- (IBAction)notificationTypeButtonTouched:(id)sender {
    
    typeAlert = [MLTableAlert tableAlertWithTitle:@"选择通知类型" cancelButtonTitle:@"取消" numberOfRows:^NSInteger (NSInteger section)
                  {
                      return self.types.allKeys.count;
                  }
                andCells:^UITableViewCell* (MLTableAlert *anAlert, NSIndexPath *indexPath)
                  {
                      static NSString *CellIdentifier = @"CellIdentifier";
                      UITableViewCell *cell = [anAlert.table dequeueReusableCellWithIdentifier:CellIdentifier];
                      if (cell == nil)
                          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                      
                      NSString *k = [self.types.allKeys objectAtIndex:indexPath.row];
                      cell.textLabel.text = k;
                      
                      return cell;
                  }];
	
	// Setting custom alert height
	typeAlert.height = 250;
	
	// configure actions to perform
	[typeAlert configureSelectionBlock:^(NSIndexPath *selectedIndex){
		//selected
        NSString *k = [self.types.allKeys objectAtIndex:selectedIndex.row];
        self.selectedNotifyType = [self.types objectForKey:k];
        
        [notificationTypeButton setTitle:[NSString stringWithFormat:@"%@ ▼", NSLocalizedString(k, @"type")] forState:UIControlStateNormal];
        
	} andCompletionBlock:^{
		//cancel
	}];
	
	// show the alert
	[typeAlert show];
}

- (IBAction)closeButtonTouched:(id)sender {
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [app.tabBarController dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

#pragma mark - Keyboard show/hide
- (void)keyboardwasShown:(NSNotification *)notif {
    
//    NSDictionary *w_info = [notif userInfo];
//	NSValue *w_aValue = [w_info objectForKey:UIKeyboardFrameEndUserInfoKey];
//	CGSize w_keyboardSize = [w_aValue CGRectValue].size;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.origin.y -= HEIGHT_TEXTVIEW;
    
    self.view.frame = aRect;
    
    
}
// 隐藏键盘
- (void)keyboardwasHidden:(NSNotification *)notif {
//    NSDictionary *w_info = [notif userInfo];
//	NSValue *w_aValue = [w_info objectForKey:UIKeyboardFrameEndUserInfoKey];
//	CGSize w_keyboardSize = [w_aValue CGRectValue].size;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.origin.y += HEIGHT_TEXTVIEW;
    
    self.view.frame = aRect;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [contentTextView resignFirstResponder];
}

@end
