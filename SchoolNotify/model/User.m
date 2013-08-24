//
//  User.m
//  SchoolNotify
//
//  Created by Jack on 24/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "User.h"

@implementation User

- (NSInteger)user_id {
    return [[originData objectForKey:API_KEY_USER_ID] intValue];
}

- (NSInteger)role_type {
    return [[originData objectForKey:API_KEY_USER_ROLE] intValue];
}

- (NSInteger)school_id {
    return [[originData objectForKey:API_KEY_USER_SCHOOL_ID] intValue];
}

@end
