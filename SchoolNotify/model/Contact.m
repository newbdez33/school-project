//
//  Contact.m
//  SchoolNotify
//
//  Created by Jack on 3/09/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "Contact.h"

@implementation Contact

- (NSString *)school_id {
    return NIL_STR([originData objectForKey:API_KEY_USER_SCHOOL_ID]);
}

- (NSString *)grade_id {
    return NIL_STR([originData objectForKey:API_KEY_USER_SCHOOL_ID]);
}

- (NSString *)class_id {
    return NIL_STR([originData objectForKey:API_KEY_CONTACT_CLASS_ID]);
}

- (NSString *)student_id {
    return NIL_STR([originData objectForKey:API_KEY_CONTACT_STUDENT_ID]);
}

- (NSString *)teacher_id {
    return NIL_STR([originData objectForKey:API_KEY_CONTACT_TEACHER_ID]);
}

- (NSString *)name {
    return NIL_STR([originData objectForKey:API_KEY_CONTACT_NAME]);
}

- (NSString *)tel {
    return NIL_STR([originData objectForKey:@"phone"]);
}


- (NSString *)class_name {
    return NIL_STR([originData objectForKey:@"class_name"]);
}

@end
