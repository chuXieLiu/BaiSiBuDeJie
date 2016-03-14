//
//  BSTabBar.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/7.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSTabBar.h"
#import "UIView+CXFrame.h"

static NSInteger const kBSTabBarItemCount = 5;

#define BS_TabBarItem_TitleFont [UIFont systemFontOfSize:13.0f]

@interface BSTabBar ()

@property (nonatomic,weak) UIButton *addButton;

@end

@implementation BSTabBar

+ (void)initialize
{
    NSDictionary *attr = @{
                           NSForegroundColorAttributeName : [UIColor lightGrayColor],
                           NSFontAttributeName : BS_TabBarItem_TitleFont
                           };
    
    NSDictionary *selAttr = @{
                              NSForegroundColorAttributeName : [UIColor darkGrayColor],
                              NSFontAttributeName : BS_TabBarItem_TitleFont
                              };
    
    [[UITabBarItem appearance] setTitleTextAttributes:attr
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:selAttr
                                             forState:UIControlStateSelected];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];

    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *addButton = [UIButton new];
        [addButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [addButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        addButton.size = addButton.currentBackgroundImage.size;
        [addButton addTarget:self action:@selector(addEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addButton];
        _addButton = addButton;
        
    }
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _addButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    CGFloat top = 0.f;
    CGFloat width = self.bounds.size.width / kBSTabBarItemCount;
    CGFloat height = self.bounds.size.height;
    NSInteger index = 0;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIControl class]] && view != _addButton) {
            if (index == 2) {
                index ++;
            }
            view.frame = CGRectMake(width * index, top, width, height);
            index ++;
        }
    }
}

#pragma mark - target event

- (void)addEvent:(UIButton *)sender
{
    if ([_tabBarDelegate respondsToSelector:@selector(tabBar:didClickAddButton:)]) {
        [_tabBarDelegate tabBar:self didClickAddButton:sender];
    }
    
}




@end
