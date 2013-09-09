//
//  NotificationService.h
//  SchoolNotify
//
//  Created by Jack on 24/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Notification.h"

@interface NotificationService : NSObject

//得到最新的消息，参数可以接受nil，如果为nil，则为第一次请求。
+ (NSArray *)fetchNewNotifications:(NSString *)last_message_id;

//得到消息内容
+ (NotificationAddition *)fetchNotificationAddition:(Notification *)notification;

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
+ (BOOL)postNotification:(NSString *)type need_reply:(NSString *)need_reply content:(NSString *)content recipients:(NSArray *)recipients;

//回复消息
+ (BOOL)postReply:(Notification *)notification content:(NSString *)content;

@end
