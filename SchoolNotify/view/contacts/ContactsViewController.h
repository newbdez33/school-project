//
//  SecondViewController.h
//  SchoolNotify
//
//  Created by Jack on 16/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@protocol ContactsViewControllerPickerDelegate

- (void)doneWithPickingContacts:(NSArray *)contacts;

@end

@interface ContactsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, EGORefreshTableHeaderDelegate, UIScrollViewDelegate, UISearchBarDelegate> {
    
    BOOL isModePicker;
    NSMutableArray *pickedContacts;
    
    IBOutlet UINavigationBar *_navbar;
    IBOutlet UITableView *contactTableView;
    
    //下拉刷新处理
    EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading;
    NSDate *lastUpdate;
    
    //搜索
    IBOutlet UISearchBar *_searchBar;
    BOOL isFiltered;
}

@property (nonatomic, strong) NSMutableDictionary *contactList;
@property (nonatomic, strong) NSMutableDictionary *sortedContactData;
@property (nonatomic, strong) NSMutableDictionary *filteredSortedContactData;
@property (nonatomic, weak) id <ContactsViewControllerPickerDelegate> delegate;

- (void)sortContactListDataWithFilter:(NSString *)name;
- (void)modeForContactsPicker;

@end
