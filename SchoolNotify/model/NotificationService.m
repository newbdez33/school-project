//
//  NotificationService.m
//  SchoolNotify
//
//  Created by Jack on 24/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "NotificationService.h"
#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@implementation NotificationService

+ (NSArray *)fetchNewNotifications:(NSString *)last_message_id {
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@&uid=%@&messageid=%@", API_HOST, API_COMMAND_NOTIFICATION_LIST, app.currentUser.user_id, last_message_id]];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request startSynchronous];
    NSError *request_error = [request error];
    if (!request_error) {
        NSString *response = [request responseString];
        NSArray *data = [response arrayFromJson];
        if (data) {
            return data;
        }else {
            NSLog(@"response incorrect:%@", response);
        }
    }
    
    return nil;
}

+ (NotificationAddition *)fetchNotificationAddition:(Notification *)notification {
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@&uid=%@&messageid=%@&type=%@", API_HOST, API_COMMAND_NOTIFICATION_CONTENT, app.currentUser.user_id, notification.message_id, notification.type]];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request startSynchronous];
    NSError *request_error = [request error];
    if (!request_error) {
        NSString *response = [request responseString];
        NSDictionary *data = [response dictionaryFromJson];
        if (data) {
            return [[NotificationAddition alloc] initWithData:data];
        }else {
            NSLog(@"response incorrect:%@", response);
        }
    }
    
    return nil;
}

//发布消息
/*
 "参数：
 uid:用户id
 range：发送范围
 1：全校， 2：全年级，3：全班级，4：个人
 school_id 学校id
 grade_id 年级id
 class_id 班级id
 student_id 学生id
 content:发送内容
 need_reply:是否需要回复"
 */
+ (BOOL)postNotification:(NSInteger)range target_id:(NSInteger)target_id content:(NSString *)content need_reply:(BOOL)need_reply {
    return NO;
}

/*
 "参数：
 uid:用户id
 notice_id:通知id
 content:回复内容"
*/
+ (BOOL)postReply:(Notification *)notification content:(NSString *)content {
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", API_HOST, API_COMMAND_NOTIFICATION_REPLY]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:app.currentUser.user_id forKey:@"uid"];
    [request setPostValue:notification.message_id forKey:@"notice_id"];
    [request setPostValue:content forKey:@"content"];
    [request startSynchronous];
    NSError *request_error = [request error];
    if (!request_error) {
        NSString *response = [request responseString];
        NSDictionary *data = [response dictionaryFromJson];
        if (data) {
            if ([[data objectForKey:@"success"] boolValue]) {
                return YES;
            }else {
                return NO;
            }
        }else {
            NSLog(@"response incorrect:%@", response);
            return NO;
        }
    }
    
    return NO;

}

@end
