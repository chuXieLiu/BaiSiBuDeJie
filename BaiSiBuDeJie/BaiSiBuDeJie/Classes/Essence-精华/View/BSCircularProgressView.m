//
//  BSCircularProgressView.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/13.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSCircularProgressView.h"

@implementation BSCircularProgressView

- (void)awakeFromNib
{
    [self setup];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.roundedCorners = 2.0f;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    if ([text rangeOfString:@"-"].location != NSNotFound) {
        text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    self.progressLabel.text = text;
    
}

@end
