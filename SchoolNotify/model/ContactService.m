//
//  ContactService.m
//  SchoolNotify
//
//  Created by Jack on 3/09/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "ContactService.h"
#import "AppDelegate.h"
#import "ASIHTTPRequest.h"

@implementation ContactService

+ (NSDictionary *)fetchContacts {
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@&role_id=%@&userid=%@", API_HOST, API_COMMAND_CONTACT_LIST, app.currentUser.role_id, app.currentUser.user_id]];
    NSLog(@"URL:%@", url);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setRequestMethod:@"GET"];
    [request startSynchronous];
    NSError *request_error = [request error];
    if (!request_error) {
        NSString *response = [request responseString];
        NSDictionary *data = [response dictionaryFromJson];
        if (data) {
            return data;
        }else {
            NSLog(@"response incorrect:%@", response);
        }
    }
    
    return nil;
}

@end
