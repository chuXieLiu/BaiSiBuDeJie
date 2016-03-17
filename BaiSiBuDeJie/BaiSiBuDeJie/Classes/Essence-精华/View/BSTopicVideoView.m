//
//  BSVideoView.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/16.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSTopicVideoView.h"
#import "BSTopic.h"
#import <UIImageView+WebCache.h>

@interface BSTopicVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;

@end

@implementation BSTopicVideoView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}


+ (instancetype)videoView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}


- (void)setTopic:(BSTopic *)topic
{
    _topic = topic;
    
    [_bigImageView sd_setImageWithURL:[NSURL URLWithString:_topic.largeImage]];
    _playcountLabel.text = [NSString stringWithFormat:@"%zd播放",_topic.playcount];
    NSInteger minutes = _topic.voicetime / 60;
    NSInteger seconds = _topic.voicetime % 60;
    _videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minutes,seconds];
}

- (IBAction)playVideo:(UIButton *)sender {
    
    
}


@end
