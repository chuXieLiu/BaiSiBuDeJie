
//
//  BSMeFooterButton.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/19.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSMeFooterButton.h"
#import <UIButton+WebCache.h>
#import "BSSquare.h"



@implementation BSMeFooterButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.left = (self.width - self.imageView.width) * 0.5;
    self.imageView.top = self.height * 0.1;

    self.titleLabel.left = 0;
    self.titleLabel.top = self.imageView.bottom;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.bottom;
}


- (void)setSquare:(BSSquare *)square
{
    _square = square;
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon]
                    forState:UIControlStateNormal];
    [self setTitle:square.name forState:UIControlStateNormal];
    
}

@end
