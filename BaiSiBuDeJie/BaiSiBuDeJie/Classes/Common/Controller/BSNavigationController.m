//
//  BSNavigationController.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/7.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSNavigationController.h"
#import "UIBarButtonItem+BS.h"

@interface BSNavigationController ()

@end

@implementation BSNavigationController

+ (void)initialize
{
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                          NSFontAttributeName : [UIFont boldSystemFontOfSize:20.0f]
                                                           }];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"]
                                       forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        
        UIBarButtonItem *backItem = [UIBarButtonItem itemWithTitle:@"返回" image:@"navigationButtonReturn" selectImage:@"navigationButtonReturnClick" target:self action:@selector(popViewControllerAnimated:)];
        ((UIButton *)backItem.customView).contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        ((UIButton *)backItem.customView).imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 0);
        viewController.navigationItem.leftBarButtonItem = backItem;
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    [super pushViewController:viewController animated:animated];
}


















@end
