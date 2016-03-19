//
//  BSTopicTableViewCell.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/11.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSTopicTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "BSTopic.h"
#import "BSTopicPictureView.h"
#import "BSTopicVideoView.h"
#import "BSTopicVoiceView.h"
#import "BSComment.h"
#import "BSUser.h"



@interface BSTopicTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;

@property (weak, nonatomic) IBOutlet UIButton *caiButton;

@property (weak, nonatomic) IBOutlet UIButton *repostButton;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UILabel *textContentLabel;

@property (nonatomic,weak) BSTopicPictureView *pictureView;

@property (nonatomic,weak) BSTopicVideoView *videoView;

@property (nonatomic,weak) BSTopicVoiceView *voiceView;

@property (weak, nonatomic) IBOutlet UIView *commentView;

@property (weak, nonatomic) IBOutlet UILabel *hotCommentLabel;



@end

@implementation BSTopicTableViewCell

+ (instancetype)topicTableViewCell
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)awakeFromNib {
    self.backgroundColor = [UIColor whiteColor];
//    _profileImageView.layer.cornerRadius = _profileImageView.width * 0.5;
//    _profileImageView.layer.masksToBounds = YES;
//    _profileImageView.layer.shouldRasterize = YES;
//    _profileImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setFrame:(CGRect)frame
{

//    frame.origin.x = kBSTopicCellMargin;
//    frame.size.width -= 2 * kBSTopicCellMargin;
    frame.origin.y += kBSTopicCellMargin;
    frame.size.height = self.topic.cellHeight - kBSTopicCellMargin;
    
    [super setFrame:frame];
}

- (void)setTopic:(BSTopic *)topic
{
    _topic = topic;
//    [_profileImageView sd_setImageWithURL:[NSURL URLWithString:_topic.profileImage] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [_profileImageView setHeader:_topic.profileImage];
    _screenNameLabel.text = _topic.screenName;
    //_screenNameLabel.text = @":҉              ❤所知丶";
    _createTimeLabel.text = _topic.createTime;
    [self setTitle:_dingButton count:_topic.ding placeHolder:@"顶"];
    [self setTitle:_caiButton count:_topic.cai placeHolder:@"踩"];
    [self setTitle:_commentButton count:_topic.comment placeHolder:@"评论"];
    [self setTitle:_repostButton count:_topic.repost placeHolder:@"转发"];
    _textContentLabel.attributedText = _topic.attributeText;
    if (_topic.type == BSEssenceTopicTypePicture) {
        [self hidenPicture:NO voice:YES video:YES];
        self.pictureView.topic = topic;
        _pictureView.frame = _topic.pictureFrame;
    } else if (_topic.type == BSEssenceTopicTypeVoice) {
        [self hidenPicture:YES voice:NO video:YES];
        self.voiceView.topic = topic;
        _voiceView.frame = _topic.pictureFrame;
    } else if (_topic.type == BSEssenceTopicTypeVideo) {
        [self hidenPicture:YES voice:YES video:NO];
        self.videoView.topic = topic;
        _videoView.frame = _topic.pictureFrame;
    } else {        // 段子
        [self hidenPicture:YES voice:YES video:YES];
    }
    BSComment *comment = _topic.topCmt.firstObject;
    if (comment.content.length > 0) {
        _commentView.hidden = NO;
        _hotCommentLabel.attributedText = comment.attributeTopContent;
    } else {
        _commentView.hidden = YES;
    }
    
}

- (void)hidenPicture:(BOOL)picture voice:(BOOL)voice video:(BOOL)video
{
    self.pictureView.hidden = picture;
    self.voiceView.hidden = voice;
    self.videoView.hidden = video;
}

- (void)setTitle:(UIButton *)button count:(NSInteger)count placeHolder:(NSString *)placeHolder
{
    if (count > 10000) {
        placeHolder = [NSString stringWithFormat:@"%.1f万",count / 10000.0f];
    } else if (count > 0) {
        placeHolder = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:placeHolder forState:UIControlStateNormal];
}

- (BSTopicPictureView *)pictureView
{
    if (_pictureView == nil) {
        BSTopicPictureView *pictureView = [BSTopicPictureView topicPictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (BSTopicVideoView *)videoView
{
    if (_videoView == nil) {
        BSTopicVideoView *videoView = [BSTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (BSTopicVoiceView *)voiceView
{
    if (_voiceView == nil) {
        BSTopicVoiceView *voiceView = [BSTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}



@end
