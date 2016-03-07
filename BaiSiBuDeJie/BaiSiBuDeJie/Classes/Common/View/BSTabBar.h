//
//  BSTabBar.h
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/7.
//  Copyright © 2016年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BSTabBar;

@protocol BSTabBarDelegate <NSObject>

- (void)tabBar:(BSTabBar *)tabBar didClickAddButton:(UIButton *)addButton;

@end

@interface BSTabBar : UITabBar

@property (nonatomic,weak) id<BSTabBarDelegate> tabBarDelegate;

@end
