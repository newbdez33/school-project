//
//  API_Interface.h
//  SchoolNotify
//
//  Created by Jack on 24/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#ifndef SchoolNotify_API_Interface_h
#define SchoolNotify_API_Interface_h

//SERVER Domain
#define API_HOST   @"http://127.0.0.1:89"

//API URL
#define API_COMMAND_USER_LOGIN @"login.php"
#define API_COMMAND_NOTIFICATION_LIST @"list"
#define API_COMMAND_NOTIFICATION_CONTENT @""

//KEYs
#define API_KEY_USER_ID @"userid"
#define API_KEY_USER_ROLE @"rold_id"
#define API_KEY_USER_SCHOOL_ID @"school_id"

#define API_KEY_NOTIFICATION_MESSAGE_ID @"messageid"
#define API_KEY_NOTIFICATION_CONTENT @"content"
#define API_KEY_NOTIFICATION_NEED_REPLY @"is_reply"
#define API_KEY_NOTIFICATION_PUBLISHER_NAME @"teacherName"
#define API_KEY_NOTIFICATION_PUBLISHER_ID @"teacher_id" //到底是下划线还是驼峰？！真傻逼啊，这API
#define API_KEY_NOTIFICATION_DATETIME @"created_at"

//课程
#define API_KEY_NOTIFICATION_SCORES @"score_array"
#define API_KEY_NOTIFICATION_SCORES_KEY @"kcName"
#define API_KEY_NOTIFICATION_SCORES_VALUE @"score"

//回复
#define API_KEY_NOTIFICATION_REPLIES @"reply_array"
#define API_KEY_NOTIFICATION_REPLIES_ID @"hfid"
#define API_KEY_NOTIFICATION_REPLIES_CONTENT @"content"
#define API_KEY_NOTIFICATION_REPLIES_DATETIME @"created_at"

#define API_KEY_NOTIFICATION_TYPE @"type"
#define API_KEY_NOTIFICATION_TYPE_SYSTEM 1  //系统消息
#define API_KEY_NOTIFICATION_TYPE_EMERGENCY 2  //紧急消息
#define API_KEY_NOTIFICATION_TYPE_SCORE 3  //成绩通知
#define API_KEY_NOTIFICATION_TYPE_NORMAL 4  //通知

#endif