//
//  BSEssenceViewController.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/7.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSEssenceViewController.h"
#import "BSEssenceTopicView.h"
#import "BSTopicViewController.h"
#import "BSTopWindow.h"
#import <Masonry.h>

@interface BSEssenceViewController ()
<
    BSEssenceTopicViewDelegate,
    UIScrollViewDelegate
>

@property (nonatomic,weak) BSEssenceTopicView *topicView;

@property (nonatomic,weak) UIScrollView *scrollView;

@end

@implementation BSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildVC];
    
    [self setupNavBar];
    
    [self setupScrollView];
    
    [self setupTopicView];
    
    [BSTopWindow show];
}

- (BSTopicModule)module
{
    return BSTopicModuleEssence;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self.topicView setSelectTopic:index animated:YES];
    UIViewController *VC = self.childViewControllers[index];
    if (![_scrollView.subviews containsObject:VC.view]) {
        [_scrollView addSubview:VC.view];
        VC.view.left = scrollView.width * index;
        VC.view.top = 0;
        VC.view.size = self.view.size;
    }
}

#pragma mark - BSEssenceTopicViewDelegate

- (void)essenceTopicView:(UIView *)topicView didSelectedIndex:(NSInteger)index
{
    CGPoint offset = _scrollView.contentOffset;
    offset.x = index * _scrollView.width;
    _scrollView.contentOffset = offset;
    [self scrollViewDidEndDecelerating:_scrollView];
}

#pragma mark - private method

- (void)setupChildVC
{
    BSTopicViewController *all = [[BSTopicViewController alloc] init];
    all.title = @"全部";
    all.type = BSEssenceTopicTypeAll;
    all.module = [self module];
    [self addChildViewController:all];
    
    BSTopicViewController *video = [[BSTopicViewController alloc] init];
    video.title = @"视频";
    video.type = BSEssenceTopicTypeVideo;
    video.module = [self module];
    [self addChildViewController:video];
    
    BSTopicViewController *picture = [[BSTopicViewController alloc] init];
    picture.type = BSEssenceTopicTypePicture;
    picture.title = @"图片";
    picture.module = [self module];
    [self addChildViewController:picture];
    
    BSTopicViewController *word = [[BSTopicViewController alloc] init];
    word.type = BSEssenceTopicTypeWord;
    word.module = [self module];
    word.title = @"段子";
    [self addChildViewController:word];
    
    BSTopicViewController *voice = [[BSTopicViewController alloc] init];
    voice.type = BSEssenceTopicTypeVoice;
    voice.module = [self module];
    voice.title = @"声音";
    [self addChildViewController:voice];
}

- (void)setupNavBar
{
    self.view.backgroundColor = BS_RGBAColor(223.0, 223.0, 223.0, 1.0);
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setupTopicView
{
    BSEssenceTopicView *topicView = [[BSEssenceTopicView alloc] initWithTopics:@[
                                                                                 @"全部",
                                                                                 @"视频",
                                                                                 @"图片",
                                                                                 @"段子",
                                                                                 @"声音"
                                                                                 ]
                                                                      delegate:self];
    [topicView setSelectTopic:0 animated:YES];
    topicView.backgroundColor = BS_RGBAColor(248, 248, 248, 0.8);
    [self.view addSubview:topicView];
    _topicView = topicView;
    [topicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(kBSEssenceTopicViewHeight));
    }];
}

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    scrollView.pagingEnabled = YES;
    _scrollView = scrollView;
    _scrollView.delegate = self;
    _scrollView.backgroundColor = BS_RGBAColor(233, 233, 233, 1.0);
    _scrollView.contentSize = CGSizeMake(5 * self.view.width, 0);
    [self scrollViewDidEndDecelerating:_scrollView];
}


@end
