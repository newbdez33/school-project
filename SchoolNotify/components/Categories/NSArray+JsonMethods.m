//
//  NSArray+JsonMethods.m
//  SchoolNotify
//
//  Created by Jack on 9/09/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "NSArray+JsonMethods.h"

@implementation NSArray (JsonMethods)

- (NSString *)jsonString {
    NSError* error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
