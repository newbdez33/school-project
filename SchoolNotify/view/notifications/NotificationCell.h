//
//  NotificationCell.h
//  SchoolNotify
//
//  Created by Jack on 26/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *publisherLabel;
@property (nonatomic, strong) IBOutlet UILabel *publishDateTime;

@end
