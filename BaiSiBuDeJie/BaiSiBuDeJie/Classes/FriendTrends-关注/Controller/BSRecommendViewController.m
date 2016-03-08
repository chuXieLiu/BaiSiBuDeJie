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
#import "NSObject+BSModel.h"
#import "BSRecommendTableViewCell.h"
#import "BSRecomendUserTableViewCell.h"
#import <MJRefresh.h>

static NSString * const kBSCategoryTableViewCellIdentifier = @"kBSCategoryTableViewCellIdentifier";

static NSString * const kBSUSerTableViewCellIdentifier = @"kBSUSerTableViewCellIdentifier";

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden = YES;
    
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    [SVProgressHUD show];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [[BSAPIClient shareManager] GET:kBSAPIBaseURLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.categories = [BSRecommendCategory bs_modelWithDictionaryList:responseObject[@"list"]];
        [self.categoryTableView reloadData];
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

- (void)loadNewUsers
{
    BSRecommendCategory *category = [self currentSelectedCategory];
    category.currentPage = 1;
    NSDictionary *params = [self paramsWithCategoryId:category.id currentPage:category.currentPage];
    [[BSAPIClient shareManager] GET:kBSAPIBaseURLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [category.users removeAllObjects];
        [category.users addObjectsFromArray:[BSRecomendUser bs_modelWithDictionaryList:responseObject[@"list"]]];
        category.total = [responseObject[@"total"] integerValue];
        [self.userTableView reloadData];
        [self.userTableView.mj_header endRefreshing];
        [self settingFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BSLog(@"%@",error);
        [self.userTableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreUsers
{
    BSRecommendCategory *category = [self currentSelectedCategory];
    category.currentPage ++;
    NSDictionary *params = [self paramsWithCategoryId:category.id currentPage:category.currentPage];
    [[BSAPIClient shareManager] GET:kBSAPIBaseURLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [category.users addObjectsFromArray:[BSRecomendUser bs_modelWithDictionaryList:responseObject[@"list"]]];
        category.total = [responseObject[@"total"] integerValue];
        if (category != [self currentSelectedCategory]) return ;
        [self.userTableView reloadData];
        [self.userTableView.mj_header endRefreshing];
        [self settingFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BSLog(@"%@",error);
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


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    } else {
        if (self.categories.count) {
            BSRecommendCategory *category = [self currentSelectedCategory];
            [self settingFooterState];
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
        return 44.0f;
    } else {
        return 66.0f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        BSRecommendCategory *category = self.categories[indexPath.row];
        if (category.users.count) {
            [self.userTableView reloadData];
        } else {
            [self.userTableView reloadData];    // 先刷新数据，
            [self.userTableView.mj_header beginRefreshing];
        }
    }
}

- (NSDictionary *)paramsWithCategoryId:(NSInteger)categoryId currentPage:(NSInteger)page
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    if (categoryId) {
        params[@"category_id"] = @(categoryId);
    }
    if (page) {
        params[@"page"] = @(page);
    }
    return params.copy;
}

- (BSRecommendCategory *)currentSelectedCategory
{
    return self.categories[[self.categoryTableView indexPathForSelectedRow].row];
}


- (NSArray *)categories
{
    if (_categories == nil) {
        _categories = @[].copy;
    }
    return _categories;
}

+ (instancetype)recommendViewController
{
    return [UIStoryboard storyboardWithName:NSStringFromClass([self class]) bundle:nil].instantiateInitialViewController;
}

- (void)dealloc
{
    _categories = nil;
    _categoryTableView = nil;
    _userTableView = nil;
    [[BSAPIClient shareManager].operationQueue cancelAllOperations];
}

@end
