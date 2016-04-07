//
//  ChatTableViewController.m
//  CGHWeChat
//
//  Created by caigehui on 4/5/16.
//  Copyright © 2016 caigehui. All rights reserved.
//

#import "ChatTableViewController.h"
#import "SearchController.h"
#import "ColorConfig.h"
@interface ChatTableViewController ()
@property (nonatomic, strong) SearchController *searchController;
@end

@implementation ChatTableViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"微信";
    [self setupSearchBar];
}


- (void)setupSearchBar
{
    SearchController *searchController = [[SearchController alloc] init];
    _searchController = searchController;
    [searchController.searchBar setPlaceholder:@"搜索"];
    [searchController.searchBar setTintColor:GREEN_COLOR];
    [searchController.searchBar setBarTintColor:SEARCHBAR_COLOR];
    [searchController.searchBar sizeToFit];
    [searchController.searchBar.layer setBorderWidth:0.5f];
    [searchController.searchBar.layer setBorderColor:[UIColor groupTableViewBackgroundColor].CGColor];

    [self.tableView setTableHeaderView:self.searchController.searchBar];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    return cell;
}

#pragma mark - getters and setters

@end
