//
//  BSCommentViewController.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/16.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSCommentViewController.h"
#import "BSTopicTableViewCell.h"
#import "BSTopic.h"
#import <MJRefresh.h>
#import "BSComment.h"
#import "BSCommentTableViewCell.h"
#import "BSCommentHeaderView.h"

static NSString * const kBSCommentTableViewCellIdentifier = @"kBSCommentTableViewCellIdentifier";

@interface BSCommentViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSArray *hotComments;

@property (nonatomic,strong) NSMutableArray *comments;

@property (nonatomic,strong) NSArray *topCmt;

@property (nonatomic,assign) NSInteger page;

@property (nonatomic,assign) BOOL isLoadNewComment; // 是否正在刷新

@end

@implementation BSCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupHeader];
    
    [self setupRefresh];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hotComments.count && self.comments.count) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger commentCount = self.comments.count;
    if (section == 0) {
        if (hotCount) {
            return hotCount;
        }
        return commentCount;
    }
    return commentCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBSCommentTableViewCellIdentifier];
    cell.comment = [self commentWithIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    BSCommentHeaderView *header = [BSCommentHeaderView commentHeaderViewWithTableView:tableView];
    NSInteger hotCount = self.hotComments.count;
    NSString *title = @"最新评论";
    if (section == 0) {
        title = hotCount ? @"最热评论" : @"最新评论";
    }
    header.title = title;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSComment *comment = [self commentWithIndexPath:indexPath];
    return comment.cellHeight;
}

#pragma mark - target event 

- (void)loadNewComments
{
    _isLoadNewComment = YES;
    @weakify(self)
    [BSComment loadNewCommentWithTopicId:_topic.topicId block:^(NSArray *comments, NSArray *hots, NSInteger total, NSError *error) {
        @strongify(self)
        if (!_isLoadNewComment) return ;
        if (!error) {
            if (comments) {
                [self.comments removeAllObjects];
                [self.comments addObjectsFromArray:comments];
            }
            if (hots) {
                self.hotComments = hots;
            }
            [self.tableView reloadData];
            if (self.comments.count >= total) {
                self.tableView.mj_footer.hidden = YES;
            } else {
                self.tableView.mj_footer.hidden = NO;
            }
        } else {
            [SVProgressHUD showErrorWithStatus:kBSAPIResponseErrorString];
        }
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreComments
{
    _isLoadNewComment = NO;
    NSInteger page = self.page + 1;
    BSComment *cmt = [self.comments lastObject];
    [BSComment loadMoreCommentWithTopicId:_topic.topicId lastCommentId:cmt.commentId page:page block:^(NSArray *comments, NSArray *hots, NSInteger total, NSError *error) {
        if (_isLoadNewComment) return ;
        if (!error) {
            if (comments) {
                [self.comments addObjectsFromArray:comments];
                self.page = page;
                [self.tableView reloadData];
                if (self.comments.count >= total) {
                    self.tableView.mj_footer.hidden = YES;
                } else {
                    self.tableView.mj_footer.hidden = NO;
                }
            }
        } else {
            [SVProgressHUD showErrorWithStatus:kBSAPIResponseErrorString];
        }
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - private method

- (void)setupTableView
{
    self.title = @"评论";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSCommentTableViewCell class]) bundle:nil] forCellReuseIdentifier:kBSCommentTableViewCellIdentifier];
}

- (void)setupHeader
{
    UIView *header = [[UIView alloc] init];
    BSTopicTableViewCell *topicView = [BSTopicTableViewCell topicTableViewCell];
    if (_topic.topCmt) {
        _topCmt = _topic.topCmt;
        _topic.topCmt = nil;
        [_topic setValue:@0 forKey:@"cellHeight"];
    }
    
    topicView.topic = _topic;
    [header addSubview:topicView];
    topicView.size = CGSizeMake(BS_SCREEN_WIDTH, _topic.cellHeight);
    header.height = _topic.cellHeight;
    header.backgroundColor = BS_RGBAColor(233, 233, 233, 10);
    self.tableView.tableHeaderView = header;
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_topCmt) {
        _topic.topCmt = _topCmt;
        [_topic setValue:@0 forKey:@"cellHeight"];
    }
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    self.tableView.mj_footer.hidden = YES;
}

- (BSComment *)commentWithIndexPath:(NSIndexPath *)indexPath
{
    NSInteger hotCount = self.hotComments.count;
    if (indexPath.section == 0) {
        if (hotCount) {
            return self.hotComments[indexPath.row];
        }
        return self.comments[indexPath.row];
    }
    return self.comments[indexPath.row];
}

#pragma mark - lazy

- (NSArray *)hotComments
{
    if (_hotComments == nil) {
        _hotComments = @[].copy;
    }
    return _hotComments;
}

- (NSMutableArray *)comments
{
    if (_comments == nil) {
        _comments = @[].mutableCopy;
    }
    return _comments;
}



@end
