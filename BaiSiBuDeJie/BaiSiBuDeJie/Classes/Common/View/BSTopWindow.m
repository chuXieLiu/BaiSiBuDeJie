//
//  BSTopWindow.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/17.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSTopWindow.h"

static UIWindow *_window;

static CGFloat const kBSTopWindowHeight = 20.0f;

@implementation BSTopWindow

+ (void)initialize
{
    _window = [[UIWindow alloc] init];
    _window.frame = CGRectMake(0, 0, BS_SCREEN_WIDTH, kBSTopWindowHeight);
    _window.windowLevel = UIWindowLevelAlert;
    _window.backgroundColor = [UIColor clearColor];
    UIGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DidTapTopWindow)];
    [_window addGestureRecognizer:tapGes];
}

+ (void)DidTapTopWindow
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewSuperView:window];
}

+ (void)searchScrollViewSuperView:(UIView *)superView
{
    for (UIScrollView *subview in superView.subviews) {
        if ([subview isKindOfClass:[UIScrollView class]]) {
            if ([subview isShowingOnKeyWindow]) {
                CGPoint offset = subview.contentOffset;
                offset.y = -subview.contentInset.top;
                [subview setContentOffset:offset animated:YES];
            }
        }
        [self searchScrollViewSuperView:subview];
    }
}

+ (void)show
{
    _window.hidden = NO;
}

+ (void)hiden
{
    _window.hidden = YES;
}

@end
