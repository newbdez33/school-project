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

#if TARGET_IPHONE_SIMULATOR
    #define API_HOST   @"http://127.0.0.1:8091"
#else
    #define API_HOST   @"http://106.187.34.26:8091"
#endif

//API URL
#define API_COMMAND_USER_LOGIN @"login.php"
#define API_COMMAND_NOTIFICATION_LIST @"notice.php?mod=list"
#define API_COMMAND_NOTIFICATION_CONTENT @"notice.php?mod=view"
#define API_COMMAND_NOTIFICATION_REPLY @"notice.php?mod=reply"
#define API_COMMAND_NOTIFICATION_PUBLISH @"notice.php?mod=add"
#define API_COMMAND_CONTACT_LIST @"notice.php?mod=get_contacts"

//KEYs
#define API_KEY_SUCCESS @"success"
#define API_KEY_ERROR_MESSAGE @"error_msg"

#define API_KEY_USER_ID @"userid"
#define API_KEY_USER_ROLE @"role_id"
#define API_KEY_USER_SCHOOL_ID @"school_id"

#define API_KEY_CONTACT_GRADE_ID @"grade_id"
#define API_KEY_CONTACT_CLASS_ID @"class_id"
#define API_KEY_CONTACT_STUDENT_ID @"student_id"
#define API_KEY_CONTACT_TEACHER_ID @"teacher_id"
#define API_KEY_CONTACT_NAME @"name"

#define API_KEY_NOTIFICATION_MESSAGE_ID @"messageid"
#define API_KEY_NOTIFICATION_CONTENT @"content"
#define API_KEY_NOTIFICATION_NEED_REPLY @"is_reply"
#define API_KEY_NOTIFICATION_NEED_REPLY_NO_NEED_REPLY @"0"
#define API_KEY_NOTIFICATION_NEED_REPLY_NEED_REPLY @"1"
#define API_KEY_NOTIFICATION_NEED_REPLY_DID_REPLY @"2"
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
