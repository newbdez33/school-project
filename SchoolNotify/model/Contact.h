//
//  Contact.h
//  SchoolNotify
//
//  Created by Jack on 3/09/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "Domain.h"

@interface Contact : Domain

//学校id
@property (nonatomic, strong) NSString *school_id;

//年级id
@property (nonatomic, strong) NSString *grade_id;

//班级id
@property (nonatomic, strong) NSString *class_id;

//班级
@property (nonatomic, strong) NSString *class_name;

//学生id
@property (nonatomic, strong) NSString *student_id;

//教师id
@property (nonatomic, strong) NSString *teacher_id;

//姓名
@property (nonatomic, strong) NSString *name;

//tel
@property (nonatomic, strong) NSString *tel;

+ (Contact *)guessWithData:(NSDictionary *)data;

@end
