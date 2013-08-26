//
//  User.h
//  SchoolNotify
//
//  Created by Jack on 24/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "Domain.h"

@interface User : Domain

//userid:用户id
@property (nonatomic) NSString *user_id;
//role_id:用户权限
//1：super user
//2：学校/教务处权限
//3：教师权限
//4：家长/学生
@property (nonatomic) NSString *role_type;
//school_id:学校id
@property (nonatomic) NSString *school_id;

@end
