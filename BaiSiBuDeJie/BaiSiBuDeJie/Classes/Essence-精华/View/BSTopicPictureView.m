//
//  BSTopicPictureView.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/12.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSTopicPictureView.h"
#import "BSTopic.h"
#import <UIImageView+WebCache.h>
#import "BSCircularProgressView.h"
#import "BSPictureViewController.h"


@interface BSTopicPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;

@property (weak, nonatomic) IBOutlet BSCircularProgressView *progressView;

@end

@implementation BSTopicPictureView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTap:)];
    [_bigImageView addGestureRecognizer:tapGesture];
}

+ (instancetype)topicPictureView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}


- (void)setTopic:(BSTopic *)topic
{
    _topic = topic;
    if (_topic.isGif) {
        _gifImageView.hidden = NO;
    } else {
        _gifImageView.hidden = YES;
    }
    if (_topic.isLongPicture) {
        _seeBigPictureButton.hidden = NO;
    } else {
        _seeBigPictureButton.hidden = YES;
    }
    if ( _topic.progress <= 1.0f) {
        _progressView.hidden = NO;
        [_progressView setProgress:_topic.progress animated:NO];
    } else {
        _progressView.hidden = YES;
    }
    [_bigImageView sd_setImageWithURL:[NSURL URLWithString:_topic.largeImage]
                     placeholderImage:nil
                              options:SDWebImageRetryFailed
    progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        _progressView.hidden = NO;
        CGFloat progress = MAX(1.0 * receivedSize  / expectedSize, 0);
        if (progress < 0) {
            BSLog(@"%f",progress);
        }
        _topic.progress = progress;
        
        [_progressView setProgress:progress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _progressView.hidden = YES;
        [[SDImageCache sharedImageCache] clearMemory];
        _bigImageView.image = image;
    }];
    

}

- (void)imageViewDidTap:(UITapGestureRecognizer *)sender
{
    BSPictureViewController *pictureVC = [[BSPictureViewController alloc] init];
    pictureVC.topic = _topic;
    pictureVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:pictureVC animated:YES completion:nil];
}



@end
