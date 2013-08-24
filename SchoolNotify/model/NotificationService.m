//
//  NotificationService.m
//  SchoolNotify
//
//  Created by Jack on 24/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "NotificationService.h"

@implementation NotificationService

+ (NSArray *)fetchNewNotifications:(NSString *)last_message_id {
    return nil;
}

+ (Notification *)fetchNotificationAddition:(Notification *)notification {
    //加入 addition
    return notification;
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
    return NO;
}

@end
