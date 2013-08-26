//
//  Util.m
//  SchoolNotify
//
//  Created by Jack on 26/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "Util.h"

@implementation Util

//得到Document目录
+ (NSString *)appDocumentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

//消息持久
+ (BOOL)saveNotificationList_v1:(NSMutableArray *)list {
    NSString *documentsDirectory = [Util appDocumentsDirectory];
    NSString *notificationFile = [documentsDirectory stringByAppendingPathComponent:@"notifications_v1"];
    return [NSKeyedArchiver archiveRootObject:list toFile:notificationFile];
}

+ (NSArray *)loadNotificationList_v1 {
    return nil;
}

@end
