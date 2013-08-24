//
//  UserService.h
//  SchoolNotify
//
//  Created by Jack on 24/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserService : NSObject

+ (User *)login:(NSString *)username password:(NSString *)password;
+ (void)logout;

@end
