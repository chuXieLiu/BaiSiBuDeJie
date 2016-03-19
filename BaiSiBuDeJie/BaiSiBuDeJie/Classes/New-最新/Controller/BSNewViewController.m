//
//  BSNewViewController.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/7.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSNewViewController.h"

@interface BSNewViewController ()

@end

@implementation BSNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BS_RGBAColor(233, 233, 233, 1.0);
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

- (BSTopicModule)module
{
    return BSTopicModuleNew;
}



@end
