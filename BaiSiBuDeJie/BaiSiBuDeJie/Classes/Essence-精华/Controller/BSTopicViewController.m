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

static NSString * const kBSTopicTableViewCellIdentifier = @"kBSTopicTableViewCellIdentifier";

@interface BSTopicViewController ()

@property (nonatomic,strong) NSMutableArray *topics;

@end

@implementation BSTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(29);
    
    @weakify(self)
    [[BSAPIClient shareManager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary  *responseObject) {
        @strongify(self)
        [self.topics addObjectsFromArray:[BSTopic bs_modelWithDictionaryList:responseObject[@"list"]]];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];;
     
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
    return 200.0f;
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


#pragma mark - lazy

- (NSMutableArray *)topics
{
    if (_topics == nil) {
        _topics = @[].mutableCopy;
    }
    return _topics;
}


@end
