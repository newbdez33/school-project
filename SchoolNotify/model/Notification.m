//
//  Notification.m
//  SchoolNotify
//
//  Created by Jack on 24/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "Notification.h"

@implementation Notification

//@property (nonatomic, strong) NSString *message_id;
- (NSString *)message_id {
    return NIL_STR([originData objectForKey:API_KEY_NOTIFICATION_MESSAGE_ID]);
}

- (void)setMessage_id:(NSString *)message_id {
    //
}

//@property (nonatomic, strong) NSString *content;
- (NSString *)content {
    return NIL_STR([originData objectForKey:API_KEY_NOTIFICATION_CONTENT]);
}

- (void)setContent:(NSString *)content {
    //
}

//@property (nonatomic) BOOL need_reply;
- (BOOL)need_reply {
    return [[originData objectForKey:API_KEY_NOTIFICATION_NEED_REPLY] boolValue];
}

- (void)setNeed_reply:(BOOL)need_reply {
    //
}


//@property (nonatomic, strong) NSString *publisher_name;
- (NSString *)publisher_name {
    return NIL_STR([originData objectForKey:API_KEY_NOTIFICATION_PUBLISHER_NAME]);
}

- (void)setPublisher_name:(NSString *)publisher_name {
    //
}

//@property (nonatomic, strong) NSString *publisher_id;
- (NSString *)publisher_id {
    return NIL_STR([originData objectForKey:API_KEY_NOTIFICATION_PUBLISHER_ID]);
}

- (void)setPublisher_id:(NSString *)publisher_id {
    //
}

@end
