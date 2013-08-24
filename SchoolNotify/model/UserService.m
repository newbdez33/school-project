//
//  UserService.m
//  SchoolNotify
//
//  Created by Jack on 24/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "UserService.h"
#import "ASIHTTPRequest.h"

@implementation UserService

+ (User *)login:(NSString *)username password:(NSString *)password {
    
    //注意这个狗血API不是我设计的，我已经建议过全部用JSON POST，可是API设计相关人员不采用我的建议！
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?username=%@&password=%@", API_HOST, API_COMMAND_USER_LOGIN, username, password]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        NSDictionary *data = [response dictionaryFromJson];
        if (data) { //TODO 判断success，获得错误信息
            User *user = [[User alloc] initWithData:data];
            return user;
        }else {
            //handling error, 数据出错
            return nil;
        }
        
    }
    return nil;
}

+ (void)logout {
    //
}

@end
