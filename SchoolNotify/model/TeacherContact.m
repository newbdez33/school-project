//
//  TeacherContact.m
//  SchoolNotify
//
//  Created by Jack on 4/09/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "TeacherContact.h"

@implementation TeacherContact

- (NSString *)name {
    return NIL_STR([originData objectForKey:@"teacher_name"]);
}

@end
