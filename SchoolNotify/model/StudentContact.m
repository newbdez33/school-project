//
//  StudentContact.m
//  SchoolNotify
//
//  Created by Jack on 4/09/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "StudentContact.h"

@implementation StudentContact

- (NSString *)name {
    return NIL_STR([originData objectForKey:@"student_name"]);
}

@end
