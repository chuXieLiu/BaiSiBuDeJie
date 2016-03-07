//
//  BSMeViewController.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/7.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSMeViewController.h"
#import "UIBarButtonItem+BS.h"

@interface BSMeViewController ()

@end

@implementation BSMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BS_RGBAColor(233, 233, 233, 1.0);
    self.title = @"我的";
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


#pragma mark - target event

- (void)settinEvent:(UIBarButtonItem *)sender
{
    BSLogFunc
}

- (void)moonEvent:(UIBarButtonItem *)sender
{
    BSLogFunc
}



@end
