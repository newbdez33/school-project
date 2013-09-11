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
        isFiltered = NO;
        isModePicker = NO;
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
            [self sortContactListDataWithFilter:nil];
            
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
    
    [self configSearchBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Related
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *keys = nil;
    if (isFiltered) {
        keys = [self.filteredSortedContactData allKeys];
    }else {
        keys = [self.sortedContactData allKeys];
    }
    NSString *title = [NSString stringWithFormat:@"%@", [keys objectAtIndex:section]];
    return NSLocalizedString(title, @"section header title");
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSArray *keys = nil;
    if (isFiltered) {
        keys = [self.filteredSortedContactData allKeys];
    }else {
        keys = [self.sortedContactData allKeys];
    }
    return keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *keys = nil;
    NSDictionary *tableData = nil;
    if (isFiltered) {
        keys = [self.filteredSortedContactData allKeys];
        tableData = self.filteredSortedContactData;
    }else {
        keys = [self.sortedContactData allKeys];
        tableData = self.sortedContactData;
    }

    NSString *title = [NSString stringWithFormat:@"%@", [keys objectAtIndex:section]];
    NSArray *list = [tableData objectForKey:title];
    
    return list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ContactCell";
    ContactCell *cell = (ContactCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:XIB(@"ContactCell") owner:self options:nil] lastObject];
    }

    
    NSArray *keys = nil;
    NSDictionary *tableData = nil;
    if (isFiltered) {
        keys = [self.filteredSortedContactData allKeys];
        tableData = self.filteredSortedContactData;
    }else {
        keys = [self.sortedContactData allKeys];
        tableData = self.sortedContactData;
    }
    NSString *title = [NSString stringWithFormat:@"%@", [keys objectAtIndex:indexPath.section]];
    NSArray *list = [tableData objectForKey:title];
    
    Contact *contact = [list objectAtIndex:indexPath.row];
    cell.nameLabel.text = contact.name;
    cell.telLabel.text = contact.tel;
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (isModePicker==YES) {
        if ([pickedContacts containsObject:contact]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    

    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactCell *cell = [[[NSBundle mainBundle] loadNibNamed:XIB(@"ContactCell") owner:self options:nil] lastObject];
    // cell的高度
    return CGRectGetHeight(cell.frame);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *keys = nil;
    NSDictionary *tableData = nil;
    if (isFiltered) {
        keys = [self.filteredSortedContactData allKeys];
        tableData = self.filteredSortedContactData;
    }else {
        keys = [self.sortedContactData allKeys];
        tableData = self.sortedContactData;
    }
    NSString *title = [NSString stringWithFormat:@"%@", [keys objectAtIndex:indexPath.section]];
    NSArray *list = [tableData objectForKey:title];
    
    Contact *contact = [list objectAtIndex:indexPath.row];
    
    if (isModePicker) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [pickedContacts removeObject:contact];
        }else if (cell.accessoryType == UITableViewCellAccessoryNone) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [pickedContacts addObject:contact];
        }
        // This removes the highlighting of the Cell
        //[tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    
    NSString *tel = contact.tel;
    
    //打电话
    if (tel && ![tel isEqualToString:@""]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", tel]]];
    }

}

- (void)modeForContactsPicker {
    
    isModePicker = YES;
    
    pickedContacts = [NSMutableArray array];

    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", @"Done") style:UIBarButtonItemStyleDone target:self action:@selector(doneWithPicking)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    contactTableView.allowsMultipleSelection = YES;
    
    //禁用下拉刷新
    [_refreshHeaderView removeFromSuperview];
    _refreshHeaderView = nil;
    

    [contactTableView reloadData];
}

- (void)doneWithPicking {
    //fetch array of selected contacts
    
    if (self.delegate) {
        [self.delegate doneWithPickingContacts:pickedContacts];
    }
}

- (void)sortContactListDataWithFilter:(NSString *)name {
    
    NSMutableDictionary *workingData = [NSMutableDictionary dictionaryWithDictionary:@{@"班级": [NSMutableArray array], @"老师":[NSMutableArray array]}];
    NSPredicate *namePredicate = nil;
    if (name!=nil) {
        namePredicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            Contact *obj = evaluatedObject;
            NSPredicate *match = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", name];
            if ([match evaluateWithObject:obj.name]) {
                return YES;
            }
            return NO;
        }];
    }
    
    //1. 班级 Section
    //TODO 直接写key了，api不稳定，等重构吧。
    NSArray *classList = [self.contactList objectForKey:@"class"];
    NSMutableArray *classArray = [workingData objectForKey:@"班级"];
    [classList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ClassContact *c = [[ClassContact alloc] initWithData:obj];
        [classArray addObject:c];
    }];
    if (namePredicate) {
        [classArray filterUsingPredicate:namePredicate];
    }
    
    //2. 老师
    NSMutableArray *teacherList = [self.contactList objectForKey:@"teacher"];
    NSMutableArray *teacherArray = [workingData objectForKey:@"老师"];
    [teacherList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TeacherContact *c = [[TeacherContact alloc] initWithData:obj];
        [teacherArray addObject:c];
    }];
    if (namePredicate) {
        [teacherArray filterUsingPredicate:namePredicate];
    }

    
    //3. 学生
    NSMutableArray *studentList = [self.contactList objectForKey:@"student"];
    [studentList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        StudentContact *c = [[StudentContact alloc] initWithData:obj];
        NSString *class_name = c.class_name;
        if ([workingData objectForKey:class_name] == nil) {
            [workingData setObject:[NSMutableArray array] forKey:class_name];
        }
        NSMutableArray *studentArray = [workingData objectForKey:class_name];
        [studentArray addObject:c];
        if (namePredicate) {
            [studentArray filterUsingPredicate:namePredicate];
        }

    }];
    
    if (name!=nil) {
        self.filteredSortedContactData = workingData;
    }else {
        self.sortedContactData = workingData;
    }
    
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

#pragma mark - SearchBar
// 初始化搜索条
- (void) configSearchBar {
    
    _searchBar.delegate = self;
//    _searchBar.translucent = YES;
    
//    for (UIView *subview in _searchBar.subviews)
//    {
//        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
//        {
//            [subview removeFromSuperview];
//            break;
//        }
//    }
    _searchBar.showsCancelButton = YES;
    _searchBar.delegate = self;
    
    [_searchBar setShowsCancelButton:NO animated:YES];

    for (UIView *searchBarSubview in [_searchBar subviews]) {
        
        if ([searchBarSubview conformsToProtocol:@protocol(UITextInputTraits)]) {
            
            @try {
                
                [(UITextField *)searchBarSubview setReturnKeyType:UIReturnKeyDone];
                [(UITextField *)searchBarSubview setKeyboardAppearance:UIKeyboardAppearanceAlert];
            }
            @catch (NSException * e) {
                
                // ignore exception
            }
        }
    }
    

    UIButton* _cancelButton = [_searchBar valueForKey:@"_cancelButton"];
    [_cancelButton setTitle:NSLocalizedString(@"取消", @"cancel") forState:UIControlStateNormal];
    
    [self setCancelButtonEnabled];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(actionOnDidKeyboardHide)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
    
}

- (void) actionOnDidKeyboardHide
{
    [self setCancelButtonEnabled];
}

// 设置取消按钮为不可见
- (void) setCancelButtonEnabled
{
    UIButton* _cancelButton = [_searchBar valueForKey:@"_cancelButton"];
    [_cancelButton setEnabled:YES];
    [_cancelButton setBackgroundColor:[UIColor clearColor]];
    //[_cancelButton setTintColor:[UIColor blackColor]];
}

// called when text starts editing
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchBar.text.length==0) {
        isFiltered = NO;
    }else {
        isFiltered = YES;
        [self sortContactListDataWithFilter:searchText];
    }
    
    [contactTableView reloadData];
}

// called when text ends editing
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    searchBar.text=  [searchBar.text stringByTrimmingCharactersInSet:blank];
    [searchBar resignFirstResponder];
}

// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];

    //开始搜索
    NSLog(@"开始搜索");
}

// called when cancel button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    searchBar.text = @"";
    
    //取消cancel
    [searchBar resignFirstResponder];
}

@end
