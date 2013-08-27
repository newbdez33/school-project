//
//  Domain.h
//  SchoolNotify
//
//  Created by Jack on 24/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Domain : NSObject {
    NSMutableDictionary *originData;   //从服务器传来的原始数据
}

@property (nonatomic) NSInteger version;

- (id)initWithData:(NSDictionary *)data;
- (NSMutableDictionary *)originData;

@end
