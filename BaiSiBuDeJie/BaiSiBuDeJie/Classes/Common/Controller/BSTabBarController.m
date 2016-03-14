//
//  BSTabBarController.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/7.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSTabBarController.h"
#import "BSNavigationController.h"
#import "BSEssenceViewController.h"
#import "BSNewViewController.h"
#import "BSTrendsViewController.h"
#import "BSMeViewController.h"
#import "BSPublishViewController.h"
#import "BSTabBarController+BS.h"
#import "BSTabBar.h"

@interface BSTabBarController ()
<
    BSTabBarDelegate
>


@end

@implementation BSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BSTabBar *tabBar = [[BSTabBar alloc] init];
    tabBar.tabBarDelegate = self;
    [self setValue:tabBar forKey:@"tabBar"];
    
    BSEssenceViewController *essenceVC = [BSEssenceViewController new];
    [self setupChildVC:essenceVC title:@"精华" image:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon"];
    
    BSNewViewController *newVC = [BSNewViewController new];
    [self setupChildVC:newVC title:@"最新" image:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"];
    
    BSTrendsViewController *trendsVC = [BSTrendsViewController new];
    [self setupChildVC:trendsVC title:@"关注" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];
    
    BSMeViewController *meVC = [BSMeViewController new];
    [self setupChildVC:meVC title:@"我" image:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"];
}

- (void)tabBar:(BSTabBar *)tabBar didClickAddButton:(UIButton *)addButton
{
    BSPublishViewController *publishVC = [[BSPublishViewController alloc] init];
    [self presentViewController:publishVC animated:NO completion:nil];
}




@end
