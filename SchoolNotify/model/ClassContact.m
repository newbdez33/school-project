//
//  ClassContact.m
//  SchoolNotify
//
//  Created by Jack on 4/09/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "ClassContact.h"

@implementation ClassContact

- (NSString *)name {
    return NIL_STR([originData objectForKey:@"class_name"]);
}

@end
