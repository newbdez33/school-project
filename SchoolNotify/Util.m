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
    NSString *documentsDirectory = [Util appDocumentsDirectory];
    NSString *notificationFile = [documentsDirectory stringByAppendingPathComponent:@"notifications_v1"];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:notificationFile];
}

+(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


@end
