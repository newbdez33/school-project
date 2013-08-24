//
//  Domain.m
//  SchoolNotify
//
//  Created by Jack on 24/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "Domain.h"

@implementation Domain

- (id)initWithData:(NSDictionary *)data {

    self = [super init];
    if (self!=nil && data!=nil) {
        originData = [[NSDictionary alloc] initWithDictionary:data];
        return self;
    }
    
    return nil;
}

@end
