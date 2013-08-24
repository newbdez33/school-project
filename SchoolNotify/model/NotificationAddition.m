//
//  NotificationAddition.m
//  SchoolNotify
//
//  Created by Jack on 24/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "NotificationAddition.h"

@implementation NotificationAddition

//@property (nonatomic, strong) NSArray *scores;
- (NSArray *)scores {
    return [originData objectForKey:API_KEY_NOTIFICATION_SCORES];
}

- (void)setScores:(NSArray *)scores {
    //
}

//@property (nonatomic, strong) NSArray *replies;
- (NSArray *)replies {
    return [originData objectForKey:API_KEY_NOTIFICATION_REPLIES];
}

- (void)setReplies:(NSArray *)replies {
    //
}

@end
