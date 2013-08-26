//
//  FirstViewController.m
//  SchoolNotify
//
//  Created by Jack on 16/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "NotificationsViewController.h"
#import "NotificationService.h"
#import "NotificationCell.h"
#import "Util.h"
#import "MBProgressHUD.h"

@interface NotificationsViewController ()

@end

@implementation NotificationsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"学校通知", @"通知");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)loadData {
    
    _reloading = YES;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //载入已存在的消息
    self.notificationList = [NSMutableArray arrayWithArray:[Util loadNotificationList_v1]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        Notification *last_notification = [[Notification alloc] initWithData:[self.notificationList lastObject]];
        NSArray *notifications = [NotificationService fetchNewNotifications:last_notification.message_id];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (notifications!=nil && notifications.count>0) {
                [self.notificationList addObjectsFromArray:notifications];
            }
            
            [notificationTableView reloadData];
            
            lastUpdate = [NSDate date];
            
            _reloading = NO;
            [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:notificationTableView];
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        });
        
    });

}

- (void)configToolbar {
    // 44.01 shifts it up 1px for some reason
    UIToolbar *tools = [[UIToolbar alloc]
                        initWithFrame:CGRectMake(0.0f, 0.0f, 70, 44.01f)];
    tools.clearsContextBeforeDrawing = NO;
    tools.clipsToBounds = NO;
    // closest I could get by eye to black, translucent style.
    tools.tintColor = [UIColor colorWithWhite:0.305f alpha:0.0f];
    // anyone know how to get it perfect?
    tools.barStyle = -1; // clear background
    NSMutableArray *buttons = [[NSMutableArray alloc] initWithCapacity:3];
    
    //    UIBarButtonItem *bi = [[UIBarButtonItem alloc]
    //                           initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    //    [buttons addObject:bi];
    
    // Add profile button.
    UIBarButtonItem *bi = [[UIBarButtonItem alloc] initWithTitle:@"发布通知" style:UIBarButtonItemStylePlain target:self action:@selector(publishNotificationButtonTouched:)];
    bi.style = UIBarButtonItemStyleBordered;
    
    [buttons addObject:bi];
    
    // Add buttons to toolbar and toolbar to nav bar.
    [tools setItems:buttons animated:NO];
    UIBarButtonItem *twoButtons = [[UIBarButtonItem alloc] initWithCustomView:tools];
    self.navigationItem.rightBarButtonItem = twoButtons;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configToolbar];
    
    [self loadData];
    
    if (_refreshHeaderView == nil) {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - notificationTableView.bounds.size.height, self.view.frame.size.width, notificationTableView.bounds.size.height)];
		view.delegate = self;
		[notificationTableView addSubview:view];
		_refreshHeaderView = view;
		
	}
}

- (void)publishNotificationButtonTouched:(id)sender {
    NSLog(@"Publish touched");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Related
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notificationList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NotificationCell";
    NotificationCell *cell = (NotificationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:XIB(@"NotificationCell") owner:self options:nil] lastObject];
    }
    
    Notification *notification = [[Notification alloc] initWithData:[self.notificationList objectAtIndex:indexPath.row]];
    NSLog(@"notification :%@", notification);
    cell.titleLabel.text = notification.content;
    cell.publisherLabel.text = notification.publisher_name;
    cell.publishDateTime.text = notification.datetime;
    
    if (notification.need_reply) {  //TODO
        [cell setBackgroundColor:[UIColor grayColor]];
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotificationCell *cell = [[[NSBundle mainBundle] loadNibNamed:XIB(@"NotificationCell") owner:self options:nil] lastObject];
    // cell的高度
    return CGRectGetHeight(cell.frame);
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    //下拉刷新时 清空搜索数据
    lastUpdate = [NSDate date];
    _reloading = YES;
    [self loadData];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return lastUpdate;
	
}

@end
