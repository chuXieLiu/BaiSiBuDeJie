//
//  BSTrendsViewController.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/7.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSTrendsViewController.h"
#import "UIBarButtonItem+BS.h"
#import "BSRecommendViewController.h"


@interface BSTrendsViewController ()

@end

@implementation BSTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BS_RGBAColor(233, 233, 233, 1.0);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:nil
                                                                     image:@"friendsRecommentIcon"
                                                               selectImage:@"friendsRecommentIcon-click"
                                                                    target:self
                                                                    action:@selector(recommendEvent:)];
}






#pragma mark - target event

- (void)recommendEvent:(UIBarButtonItem *)sender
{
    BSRecommendViewController *recommendVC = [BSRecommendViewController new];
    [self.navigationController pushViewController:recommendVC animated:YES];
}











@end
