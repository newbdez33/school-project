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

+ (User *)login:(NSString *)username password:(NSString *)password error:(NSError **)error{
    
    //注意这个狗血API不是我设计的，我已经建议过全部用JSON POST，可是API设计相关人员不采用我的建议！
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@?username=%@&password=%@", API_HOST, API_COMMAND_USER_LOGIN, username, password]];
    NSLog(@"login:%@", url);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request startSynchronous];
    NSError *request_error = [request error];
    if (!request_error) {
        NSString *response = [request responseString];
        NSDictionary *data = [response dictionaryFromJson];
        if (data) { //TODO 判断success，获得错误信息
            
            if (![[data objectForKey:API_KEY_SUCCESS] boolValue]) {
                if (error) {
                    NSString *error_message = NIL_STR([data objectForKey:API_KEY_ERROR_MESSAGE]);
                    NSDictionary *networkerror = @{API_KEY_ERROR_MESSAGE:error_message};
                    *error = [NSError errorWithDomain:@"LOGIN" code:403 userInfo:networkerror];
                }
                return nil;
            }
            
            User *user = [[User alloc] initWithData:data];
            return user;
        }
    }
    
    NSLog(@"failed:%@", request_error);
    //handling error, 数据出错
    if (error) {
        NSDictionary *networkerror = @{API_KEY_ERROR_MESSAGE:NSLocalizedString(@"服务器错误，请重试", @"error message 服务器错误")};
        *error = [NSError errorWithDomain:@"LOGIN" code:500 userInfo:networkerror];
    }
    return nil;
}

+ (void)logout {
    //
}

@end
