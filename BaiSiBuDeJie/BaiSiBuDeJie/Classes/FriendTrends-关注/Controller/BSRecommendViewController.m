//
//  BSRecommendViewController.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/8.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSRecommendViewController.h"
#import "BSRecommendCategory.h"
#import "BSRecomendUser.h"
#import "BSRecommendTableViewCell.h"
#import "BSRecomendUserTableViewCell.h"
#import <MJRefresh.h>

static NSString * const kBSCategoryTableViewCellIdentifier = @"kBSCategoryTableViewCellIdentifier";

static NSString * const kBSUSerTableViewCellIdentifier = @"kBSUSerTableViewCellIdentifier";

static CGFloat const kBSCategoryTableViewCellHeight = 44.0f;

static CGFloat const kBSUserTableViewCellHeight = 66.0f;


@interface BSRecommendViewController ()

<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (nonatomic,weak) IBOutlet UITableView *categoryTableView;
@property (nonatomic,weak) IBOutlet UITableView *userTableView;
@property (nonatomic,strong) NSArray *categories;


@end

@implementation BSRecommendViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRefresh];
    
    [SVProgressHUD show];
    @weakify(self)
    [BSRecommendCategory loadRecommendCategoriesBlock:^(NSArray *cagegories, NSError *error) {
        @strongify(self)
        if (!error) {
            [SVProgressHUD dismiss];
            self.categories = cagegories;
            [self.categoryTableView reloadData];
            [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
            [self.userTableView.mj_header beginRefreshing];
        } else {
            
            [SVProgressHUD showErrorWithStatus:kBSAPIResponseErrorString];
        }
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    } else {
        if (self.categories.count) {
            BSRecommendCategory *category = [self currentSelectedCategory];
            return category.users.count;
        }
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.categoryTableView) {
        BSRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBSCategoryTableViewCellIdentifier];
        cell.recommendCategory = self.categories[indexPath.row];
        return cell;
    } else {
        BSRecomendUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBSUSerTableViewCellIdentifier];
        BSRecommendCategory *category = [self currentSelectedCategory];
        cell.user = category.users[indexPath.row];
        return cell;
    }
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        return kBSCategoryTableViewCellHeight;
    } else {
        return kBSUserTableViewCellHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        [self settingFooterState];
        BSRecommendCategory *category = self.categories[indexPath.row];
        if (category.users.count) {
            [self.userTableView reloadData];
        } else {
            [self.userTableView reloadData];    // 先刷新数据，
            [self.userTableView.mj_header beginRefreshing];
        }
    }
}

#pragma mark - private method

- (void)setupRefresh
{
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden = YES;
}

- (void)loadNewUsers
{
    BSRecommendCategory *category = [self currentSelectedCategory];
    NSInteger page = category.currentPage;
    category.currentPage = 1;
    @weakify(self)
    [BSRecomendUser loadRecommendUsersWithCategory:category
     Block:^(NSArray *users, NSInteger total, NSError *error) {
         @strongify(self)
         if (!error) {
             [category.users removeAllObjects];
             [category.users addObjectsFromArray:users];
             category.total = total;
             if (category != [self currentSelectedCategory]) return ;
             [self.userTableView reloadData];
             [self settingFooterState];
         } else {
             // 访问失败页码回滚
             category.currentPage = page;
         }
         [self.userTableView.mj_header endRefreshing];
     }];
}

- (void)loadMoreUsers
{
    BSRecommendCategory *category = [self currentSelectedCategory];
    category.currentPage ++;
    @weakify(self)
    [BSRecomendUser loadRecommendUsersWithCategory:category
     Block:^(NSArray *users, NSInteger total, NSError *error) {
         @strongify(self)
         if (!error) {
             [category.users addObjectsFromArray:users];
             category.total = total;
             if (category != [self currentSelectedCategory]) return ;
             [self.userTableView reloadData];
             [self settingFooterState];
         } else {
             category.currentPage --;
         }
         [self.userTableView.mj_footer endRefreshing];
     }];
}

- (void)settingFooterState
{
    BSRecommendCategory *category = [self currentSelectedCategory];
    self.userTableView.mj_footer.hidden = category.total == 0;
    if (category.users.count != category.total) {
        [self.userTableView.mj_footer endRefreshing];
        [self.userTableView.mj_footer resetNoMoreData];
    } else {
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }
}

- (BSRecommendCategory *)currentSelectedCategory
{
    return self.categories[[self.categoryTableView indexPathForSelectedRow].row];
}


#pragma mark - lazy

- (NSArray *)categories
{
    if (_categories == nil) {
        _categories = @[].copy;
    }
    return _categories;
}

#pragma mark - public method

+ (instancetype)recommendViewController
{
    return [UIStoryboard storyboardWithName:NSStringFromClass([self class]) bundle:nil].instantiateInitialViewController;
}


@end
