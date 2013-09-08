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

#define HEIGHT_TEXTVIEW 160

@interface NotificationPublishViewController ()

@end

@implementation NotificationPublishViewController

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
    
    
    [self dismissViewControllerAnimated:YES completion:^{
    
        
    }];
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
