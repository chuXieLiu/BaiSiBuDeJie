//
//  UIView+CXFrame.h
//  网易新闻
//
//  Created by c_xie on 15-4-2.
//  Copyright (c) 2015年 c_xie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CXFrame)

@property (nonatomic,assign) CGFloat left;
@property (nonatomic,assign) CGFloat right;
@property (nonatomic,assign) CGFloat top;
@property (nonatomic,assign) CGFloat bottom;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGPoint origin;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGSize size;

- (BOOL)isShowingOnKeyWindow;

@end
