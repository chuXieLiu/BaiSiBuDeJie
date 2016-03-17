//
//  BSTopicViewController.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/11.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSTopicViewController.h"
#import "BSTopic.h"
#import "BSTopicTableViewCell.h"
#import <MJRefresh.h>
#import "BSCommentViewController.h"


static NSString * const kBSTopicTableViewCellIdentifier = @"kBSTopicTableViewCellIdentifier";

@interface BSTopicViewController ()

@property (nonatomic,strong) NSMutableArray *topics;

@property (nonatomic,assign) NSInteger page;    // 页码

@property (nonatomic,copy) NSString *maxtime;   // 最大帖子数

@property (nonatomic,assign) BOOL isLoadNewTopics;


@end

@implementation BSTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self setupRefresh];
}



#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BSTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBSTopicTableViewCellIdentifier];
    cell.topic = _topics[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSTopic *topic = _topics[indexPath.row];
    return topic.cellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSTopic *topic = _topics[indexPath.row];
    BSCommentViewController *commentVC = [[BSCommentViewController alloc] init];
    commentVC.topic = topic;
    [self.navigationController pushViewController:commentVC animated:YES];
}

#pragma mark - target event

- (void)loadMoreNewTopics
{
    self.isLoadNewTopics = YES;
    @weakify(self)
    [BSTopic loadNewTopicsWithType:_type Block:^(NSArray *topics, NSString *maxTime, NSError *error) {
        if (!self.isLoadNewTopics) return ;
        if (!error) {
            @strongify(self)
            [self.topics removeAllObjects];
            [self.topics addObjectsFromArray:topics];
            self.maxtime = maxTime;
            [self.tableView reloadData];
            self.page = 0;
            [self.tableView.mj_header endRefreshing];
            self.tableView.mj_footer.hidden = NO;
        } else {
            [SVProgressHUD showErrorWithStatus:kBSAPIResponseErrorString];
        }
    }];
}

- (void)loadMoreOldTopics
{
    self.isLoadNewTopics = NO;
    @weakify(self)
    [BSTopic loadMoreOldTopicsWithType:_type page:self.page + 1 maxTime:self.maxtime block:^(NSArray *topics, NSString *maxTime, NSError *error) {
        @strongify(self)
        if (self.isLoadNewTopics) return ;
        if (!error) {
            self.maxtime = maxTime;
            [self.topics addObjectsFromArray:topics];
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshing];
        } else {
            [SVProgressHUD showErrorWithStatus:kBSAPIResponseErrorString];
        }
    }];
}


#pragma mark - private method

- (void)setup
{
    self.tableView.contentInset = UIEdgeInsetsMake(kBSEssenceTopicViewHeight + kBSNavigationBarHeight, 0, kBSTabBarHeight, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kBSEssenceTopicViewHeight + kBSNavigationBarHeight, 0, kBSTabBarHeight, 0);
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSTopicTableViewCell class])
                        bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:kBSTopicTableViewCellIdentifier];
    self.view.backgroundColor = BS_RGBAColor(233, 233, 233, 1.0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadMoreNewTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreOldTopics)];
    self.tableView.mj_footer.hidden = YES;
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - lazy

- (NSMutableArray *)topics
{
    if (_topics == nil) {
        _topics = @[].mutableCopy;
    }
    return _topics;
}


@end
