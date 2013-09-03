//
//  Util.h
//  SchoolNotify
//
//  Created by Jack on 26/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

//得到Document目录
+ (NSString *)appDocumentsDirectory;

//消息持久
+ (BOOL)saveNotificationList_v1:(NSArray *)list;
+ (NSArray *)loadNotificationList_v1;

+(UIColor*)colorWithHexString:(NSString*)hex;

@end
