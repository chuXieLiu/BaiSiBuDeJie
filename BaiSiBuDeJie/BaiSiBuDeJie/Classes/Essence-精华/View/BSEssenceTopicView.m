//
//  BSEssenceTopicView.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/11.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSEssenceTopicView.h"

#define BSTopicButtonNormalFont [UIFont systemFontOfSize:13.0f]
#define BSTopicButtonDisabledFont [UIFont systemFontOfSize:14.0f]

@interface BSEssenceTopicView ()

@property (nonatomic,assign,readwrite) NSInteger currentIndex;

@property (nonatomic,weak) UIView *undline;

@property (nonatomic,weak) UIButton *lastButton;

@end

@implementation BSEssenceTopicView

- (instancetype)initWithTopics:(NSArray<NSString *> *)topics delegate:(id<BSEssenceTopicViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        _topics = topics;
        _delegate = delegate;
        NSInteger count = _topics.count;
        for (int i = 0; i < count; i++) {
            UIButton *button = [[UIButton alloc] init];
            button.tag = i+1;
            [button setTitle:_topics[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button setTitleColor:BS_RGBAColor(218, 0, 0, 1.0) forState:UIControlStateDisabled];
            [button addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
            button.titleLabel.font = BSTopicButtonNormalFont;
            [self addSubview:button];
        }
        UIView *undline = [[UIView alloc] init];
        undline.backgroundColor = [UIColor redColor];
        [self addSubview:undline];
        _undline = undline;
    }
    return self;
}



- (void)buttonDidClick:(UIButton *)sender
{
    [self setClickButton:sender animated:YES];
    if ([_delegate respondsToSelector:@selector(essenceTopicView:didSelectedIndex:)]) {
        [_delegate essenceTopicView:self didSelectedIndex:sender.tag - 1];
    }
}

- (void)setClickButton:(UIButton *)sender animated:(BOOL)animated
{
    if (_lastButton) {
        _lastButton.enabled = YES;
        _lastButton.titleLabel.font = BSTopicButtonNormalFont;

    }
    sender.enabled = NO;

    sender.titleLabel.font = BSTopicButtonDisabledFont; ///zhge
    
    _lastButton = sender;
    CGFloat undlineH = 2.0f;
    _undline.size = CGSizeMake(sender.titleLabel.width, undlineH);
    _undline.top = sender.height - undlineH;
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            _undline.centerX = sender.centerX;
        }];
    } else {
        _undline.centerX = sender.centerX;
    }
}


- (void)drawRect:(CGRect)rect
{
    [self setSelectTopic:_currentIndex animated:NO];
    [super drawRect: rect];
}

- (void)setSelectTopic:(NSInteger)index animated:(BOOL)animated
{
    if (index > _topics.count - 1) {
        return;
    }
    _currentIndex = index;
    UIButton *button = [self viewWithTag:index + 1];
    [self setClickButton:button animated:animated];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger count = _topics.count;
    CGFloat width = floorf(self.width / count);
    for (int i = 0; i < count ; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:i+1];
        button.frame = CGRectMake(i * width, 0, width, self.height);
        if (button.enabled == NO) {
            _undline.centerX = button.centerX;
        }
    }
}


@end
