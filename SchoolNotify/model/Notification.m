//
//  Notification.m
//  SchoolNotify
//
//  Created by Jack on 24/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "Notification.h"

@implementation Notification

- (id)initWithData:(NSDictionary *)data {
    
    self = [super initWithData:data];
    if (self!=nil) {
        if ([originData objectForKey:@"is_read"]==nil) {
            self.is_read = NO;
        }
        return self;
    }
    
    return nil;
}

- (BOOL)is_read {
    return [[originData objectForKey:@"is_read"] boolValue];
}

- (void)setIs_read:(BOOL)is_read {
    [originData setValue:[NSNumber numberWithBool:is_read] forKey:@"is_read"];
}

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
- (NSString *)need_reply {
    //is_reply：1：未回复， 2：已回复
    return NIL_STR([originData objectForKey:API_KEY_NOTIFICATION_NEED_REPLY]);

}

- (void)setNeed_reply:(NSString *)need_reply {
    [originData setObject:need_reply forKey:API_KEY_NOTIFICATION_NEED_REPLY];
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

- (NSString *)datetime {
    return NIL_STR([originData objectForKey:API_KEY_NOTIFICATION_DATETIME]);
}

@end
