//
//  SecondViewController.h
//  SchoolNotify
//
//  Created by Jack on 16/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface ContactsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, EGORefreshTableHeaderDelegate, UIScrollViewDelegate> {
    
    IBOutlet UITableView *contactTableView;
    
    //下拉刷新处理
    EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading;
    NSDate *lastUpdate;
}

@property (nonatomic, strong) NSMutableDictionary *contactList;
@property (nonatomic, strong) NSMutableDictionary *sortedContactData;

- (void)sortContactListData;

@end
