//
//  BSVoiceView.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/16.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSTopicVoiceView.h"
#import <UIImageView+WebCache.h>
#import "BSTopic.h"

@interface BSTopicVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;

@end

@implementation BSTopicVoiceView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
}

+ (instancetype)voiceView
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}

- (void)setTopic:(BSTopic *)topic
{
    _topic = topic;
    [_bigImageView sd_setImageWithURL:[NSURL URLWithString:_topic.largeImage]];
    _playCountLabel.text = [NSString stringWithFormat:@"%zd播放",_topic.playcount];
    NSInteger minutes = _topic.voicetime / 60;
    NSInteger seconds = _topic.voicetime % 60;
    _voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minutes,seconds];
}

- (IBAction)playVoice:(UIButton *)sender {
    
}



@end
