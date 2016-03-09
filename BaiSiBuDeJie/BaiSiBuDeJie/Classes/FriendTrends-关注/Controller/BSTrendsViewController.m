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

#import "BSLoginViewController.h"


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



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIViewController *loginVC = [[BSLoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}




#pragma mark - target event

- (void)recommendEvent:(UIBarButtonItem *)sender
{
    BSRecommendViewController *recommendVC = [BSRecommendViewController recommendViewController];
    [self.navigationController pushViewController:recommendVC animated:YES];
}











@end
