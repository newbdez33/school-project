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
+ (Notification *)fetchNotificationAddition:(Notification *)notification;

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
+ (BOOL)postNotification:(NSInteger)range target_id:(NSInteger)target_id content:(NSString *)content need_reply:(BOOL)need_reply;

//回复消息
+ (BOOL)postReply:(Notification *)notification content:(NSString *)content;

@end
