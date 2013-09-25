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
#import "StudentContact.h"
#import "TeacherContact.h"
#import "ClassContact.h"
#import "NSArray+JsonMethods.h"

@implementation NotificationService

+ (NSArray *)fetchNewNotifications:(NSString *)last_message_id {
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@&uid=%@&message_id=%@", API_HOST, API_COMMAND_NOTIFICATION_LIST, app.currentUser.user_id, last_message_id]];
    NSLog(@"url:%@", url);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request startSynchronous];
    NSError *request_error = [request error];
    if (!request_error) {
        NSString *response = [request responseString];
        NSArray *data = [response arrayFromJson];
        if (data) {
            return [[data reverseObjectEnumerator] allObjects];
        }else {
            NSLog(@"response incorrect:%@", response);
        }
    }
    
    return nil;
}

+ (NotificationAddition *)fetchNotificationAddition:(Notification *)notification {
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@&uid=%@&notice_id=%@&tzlx=%@", API_HOST, API_COMMAND_NOTIFICATION_CONTENT, app.currentUser.user_id, notification.message_id, notification.type]];
    
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
 参数：
 {
 userid:用户id
 tzlx:1.普通2.紧急3,系统
 hftype:0.不需回复 1.需要回复
 content:回复内容
 fbid:[
 {"classid" : "xxxx"}
 {"teacherid" : "xxxx"}
 {"studentid" : "xxxx"}
 ]
 
 }

 */
+ (BOOL)postNotification:(NSString *)type need_reply:(NSString *)need_reply content:(NSString *)content recipients:(NSArray *)recipients {

    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", API_HOST, API_COMMAND_NOTIFICATION_PUBLISH]];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:app.currentUser.user_id forKey:@"uid"];
    [request setPostValue:type forKey:@"tzlx"];
    [request setPostValue:need_reply forKey:@"hftype"];
    [request setPostValue:content forKey:@"content"];
    
    NSMutableArray *recipients_data = [NSMutableArray array];
    [recipients enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        if ([obj isKindOfClass:[StudentContact class]]) {
            StudentContact *c = obj;
            NSDictionary *r = @{@"student_id":c.student_id};
            [recipients_data addObject:r];
        }
        if ([obj isKindOfClass:[TeacherContact class]]) {
            TeacherContact *c = obj;
            NSDictionary *r = @{@"teacher_id":c.teacher_id};
            [recipients_data addObject:r];
        }
        if ([obj isKindOfClass:[ClassContact class]]) {
            ClassContact *c = obj;
            NSDictionary *r = @{@"class_id":c.class_id};
            [recipients_data addObject:r];
        }
    }];
    NSString *recipients_json = [recipients_data jsonString];
    [request setPostValue:recipients_json forKey:@"fbid"];
    
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
