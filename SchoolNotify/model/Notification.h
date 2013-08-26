//
//  Notification.h
//  SchoolNotify
//
//  Created by Jack on 24/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "Domain.h"
#import "NotificationAddition.h"

@interface Notification : Domain

@property (nonatomic, strong) NSString *message_id;
@property (nonatomic, strong) NSString *content;
@property (nonatomic) BOOL need_reply;
@property (nonatomic) NSString *type;
@property (nonatomic, strong) NSDate *datetime;
@property (nonatomic, strong) NotificationAddition *addition;

//是否需要合成一个发布者domain?
@property (nonatomic, strong) NSString *publisher_name;
@property (nonatomic, strong) NSString *publisher_id;

@end
