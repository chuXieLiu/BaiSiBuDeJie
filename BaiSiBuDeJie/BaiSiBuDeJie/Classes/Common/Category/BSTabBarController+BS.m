//
//  BSTabBarController+BS.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/7.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSTabBarController+BS.h"
#import "BSNavigationController.h"


@implementation BSTabBarController (BS)



- (void)setupChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage
{
    childVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                       image:[UIImage imageNamed:image]
                                               selectedImage:[UIImage imageNamed:selectImage]];
    childVC.title = title;
    BSNavigationController *nav = [[BSNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

@end
