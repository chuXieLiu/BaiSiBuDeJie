//
//  BSMeViewController.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/7.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSMeViewController.h"
#import "UIBarButtonItem+BS.h"
#import "BSMeTableViewCell.h"
#import "BSMeFooterView.h"

static NSString * const kBSMeTableViewCellIdentifier = @"kBSMeTableViewCellIdentifier";

@interface BSMeViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation BSMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
    
    [self setupTableView];
    
    [self setupFooter];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBSMeTableViewCellIdentifier];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}




#pragma mark - target event

- (void)settinEvent:(UIBarButtonItem *)sender
{
    BSLogFunc
}

- (void)moonEvent:(UIBarButtonItem *)sender
{
    BSLogFunc
}


#pragma mark - private method

- (void)setupNavBar
{
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithTitle:nil
                                                            image:@"mine-setting-icon"
                                                      selectImage:@"mine-setting-icon-click"
                                                           target:self
                                                           action:@selector(settinEvent:)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithTitle:nil
                                                         image:@"mine-moon-icon"
                                                   selectImage:@"mine-moon-icon-click"
                                                        target:self
                                                        action:@selector(moonEvent:)];
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
}

- (void)setupTableView
{
    
    self.view.backgroundColor = BS_RGBAColor(233, 233, 233, 1.0);
    self.title = @"我的";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[BSMeTableViewCell class] forCellReuseIdentifier:kBSMeTableViewCellIdentifier];
    
    self.tableView.sectionFooterHeight = 10.f;
    self.tableView.sectionHeaderHeight = 0.f;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
}

- (void)setupFooter
{
    BSMeFooterView *footerView = [[BSMeFooterView alloc] init];
    @weakify(self)
    footerView.layoutCompletionBlock = ^ () {
        @strongify(self);
        CGSize size = self.tableView.contentSize;
        size.height = self.tableView.tableFooterView.bottom;
        self.tableView.contentSize = size;
    };
    self.tableView.tableFooterView = footerView;
    
    
}



@end
