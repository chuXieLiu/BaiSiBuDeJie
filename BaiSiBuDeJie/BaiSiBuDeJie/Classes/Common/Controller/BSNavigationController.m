//
//  BSNavigationController.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/7.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSNavigationController.h"

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


@end
