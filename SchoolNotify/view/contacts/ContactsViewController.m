//
//  SecondViewController.m
//  SchoolNotify
//
//  Created by Jack on 16/08/13.
//  Copyright (c) 2013 Salmonapps.com. All rights reserved.
//

#import "ContactsViewController.h"
#import "MBProgressHUD.h"
#import "ContactService.h"
#import "Contact.h"
#import "ClassContact.h"
#import "TeacherContact.h"
#import "StudentContact.h"
#import "ContactCell.h"
#import "AppDelegate.h"

@interface ContactsViewController ()

@end

@implementation ContactsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"通讯录", @"联系人");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

- (void)loadData {
    
    _reloading = YES;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //载入已存在的消息
    self.contactList = nil; //这里可以设置载入本地缓存
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSDictionary *contacts = [ContactService fetchContacts];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (contacts!=nil && contacts.count>0) {
                self.contactList = [NSMutableDictionary dictionaryWithDictionary:contacts];
            }
            [self sortContactListData];
            
            [contactTableView reloadData];
            
            lastUpdate = [NSDate date];
            
            _reloading = NO;
            [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:contactTableView];
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        });
        
    });
    
}

							
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadData];
    
    if (_refreshHeaderView == nil) {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - contactTableView.bounds.size.height, self.view.frame.size.width, contactTableView.bounds.size.height)];
		view.delegate = self;
		[contactTableView addSubview:view];
		_refreshHeaderView = view;
		
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Related
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *keys = [self.sortedContactData allKeys];
    NSString *title = [NSString stringWithFormat:@"%@", [keys objectAtIndex:section]];
    return NSLocalizedString(title, @"section header title");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSArray *keys = [self.sortedContactData allKeys];
    return keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *keys = [self.sortedContactData allKeys];
    NSString *title = [NSString stringWithFormat:@"%@", [keys objectAtIndex:section]];
    NSArray *list = [self.sortedContactData objectForKey:title];
    
    return list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ContactCell";
    ContactCell *cell = (ContactCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:XIB(@"ContactCell") owner:self options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    NSArray *keys = [self.sortedContactData allKeys];
    NSString *title = [NSString stringWithFormat:@"%@", [keys objectAtIndex:indexPath.section]];
    NSArray *list = [self.sortedContactData objectForKey:title];
    
    Contact *contact = [list objectAtIndex:indexPath.row];
    cell.nameLabel.text = contact.name;
    cell.telLabel.text = contact.tel;
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactCell *cell = [[[NSBundle mainBundle] loadNibNamed:XIB(@"ContactCell") owner:self options:nil] lastObject];
    // cell的高度
    return CGRectGetHeight(cell.frame);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //
    
    
}

- (void)sortContactListData {
    
    self.sortedContactData = [NSMutableDictionary dictionaryWithDictionary:@{@"班级": [NSMutableArray array]}];
    
    //1. 班级 Section
    //TODO 直接写key了，api不稳定，等重构吧。
    NSMutableArray *classList = [self.contactList objectForKey:@"class"];
    NSMutableArray *classArray = [self.sortedContactData objectForKey:@"班级"];
    [classList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ClassContact *c = [[ClassContact alloc] initWithData:obj];
        [classArray addObject:c];
    }];
    
    //2. 老师
    NSMutableArray *teacherList = [self.contactList objectForKey:@"teacher"];
    [teacherList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TeacherContact *c = [[TeacherContact alloc] initWithData:obj];
        NSString *class_name = c.class_name;
        if ([self.sortedContactData objectForKey:class_name] == nil) {
            [self.sortedContactData setObject:[NSMutableArray array] forKey:class_name];
        }
        NSMutableArray *teacherArray = [self.sortedContactData objectForKey:class_name];
        [teacherArray addObject:c];
    }];
    
    //3. 学生
    NSMutableArray *studentList = [self.contactList objectForKey:@"student"];
    [studentList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        StudentContact *c = [[StudentContact alloc] initWithData:obj];
        NSString *class_name = c.class_name;
        if ([self.sortedContactData objectForKey:class_name] == nil) {
            [self.sortedContactData setObject:[NSMutableArray array] forKey:class_name];
        }
        NSMutableArray *studentArray = [self.sortedContactData objectForKey:class_name];
        [studentArray addObject:c];
    }];
    
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
