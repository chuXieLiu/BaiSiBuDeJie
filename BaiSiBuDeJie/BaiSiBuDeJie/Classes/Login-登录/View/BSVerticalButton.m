//
//  BSVerticalButton.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/9.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSVerticalButton.h"

@implementation BSVerticalButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

 - (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.top = 0;
    self.imageView.left = 0;
    
    self.titleLabel.top = self.imageView.height;
    self.titleLabel.left = 0;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.top;
    
}

@end
