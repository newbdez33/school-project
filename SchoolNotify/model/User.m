//
//  User.m
//  SchoolNotify
//
//  Created by Jack on 24/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "User.h"

@implementation User

- (NSString *)user_id {
    return NIL_STR([originData objectForKey:API_KEY_USER_ID]);
}

- (NSString *)role_id {
    return NIL_STR([originData objectForKey:API_KEY_USER_ROLE]);
}

- (NSString *)school_id {
    return NIL_STR([originData objectForKey:API_KEY_USER_SCHOOL_ID]);
}

@end
