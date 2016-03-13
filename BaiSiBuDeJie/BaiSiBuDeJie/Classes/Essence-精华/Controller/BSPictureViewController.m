//
//  BSPictureViewController.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/13.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSPictureViewController.h"
#import "BSCircularProgressView.h"
#import "BSTopic.h"
#import <UIImageView+WebCache.h>

@interface BSPictureViewController ()

@property (nonatomic,weak) UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet BSCircularProgressView *progressView;

@end

@implementation BSPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] init];
    [_scrollView addSubview:imageView];
    _imageView = imageView;
    
    CGFloat imageViewW = BS_SCREEN_WIDTH;
    CGFloat imageViewH = imageViewW * _topic.height / _topic.width;
    if (imageViewH > BS_SCREEN_HEIGHT) {
        _imageView.bounds = CGRectMake(0, 0, imageViewW, imageViewH);
        _scrollView.contentSize = CGSizeMake(imageViewW, imageViewH);
    } else {
        _imageView.size = CGSizeMake(imageViewW, imageViewH);
        _imageView.center = CGPointMake(BS_SCREEN_WIDTH * 0.5, BS_SCREEN_HEIGHT * 0.5);
    }
    [_progressView setProgress:_topic.progress animated:NO];
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_topic.largeImage] placeholderImage:nil options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        _progressView.hidden = NO;
        CGFloat progress = MAX(1.0 * receivedSize  / expectedSize, 0);
        _topic.progress = progress;
        [_progressView setProgress:progress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _progressView.hidden = YES;
        _imageView.image = image;
    }];
    
}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)save:(UIButton *)sender {
    if (!_imageView.image) {
        [SVProgressHUD showErrorWithStatus:@"图片未完全下载"];
    } else {
        UIImageWriteToSavedPhotosAlbum(_imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"图片保存失败"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"图片保存成功"];
    }
}

@end
