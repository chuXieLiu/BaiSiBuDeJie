//
//  BSCommentTableViewCell.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/16.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSCommentTableViewCell.h"
#import "BSComment.h"
#import "BSUser.h"
#import <UIImageView+WebCache.h>

@interface BSCommentTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;

@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation BSCommentTableViewCell

- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    
//    _profileImageView.layer.cornerRadius = _profileImageView.width * 0.5;
//    _profileImageView.layer.masksToBounds = YES;
//    _profileImageView.layer.shouldRasterize = YES;
//    _profileImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
//    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setFrame:(CGRect)frame
{
//    frame.origin.x += 10.0f;
//    frame.size.width -= frame.origin.x * 2;
    [super setFrame:frame];
}

- (void)setComment:(BSComment *)comment
{
    _comment = comment;
    BSUser *user = _comment.user;
//    [_profileImageView sd_setImageWithURL:[NSURL URLWithString:user.profileImage] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [_profileImageView setHeader:user.profileImage];
    if ([user.sex isEqualToString:kBSUserSexMan]) {
        _sexImageView.image = [UIImage imageNamed:@"Profile_manIcon"];
    } else {
        _sexImageView.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
    _screenNameLabel.text = user.username;
    _commentLabel.attributedText = _comment.attributeContent;
    if (_comment.likeCount) {
        _likeCountLabel.text = [NSString stringWithFormat:@"%zd",_comment.likeCount];
    } else {
        _likeCountLabel.text = @"+1";
    }
    if (_comment.voiceuri.length) {
        _voiceButton.hidden = NO;
        [_voiceButton setTitle:[NSString stringWithFormat:@"%zd''",_comment.voicetime] forState:UIControlStateNormal];
    } else {
        _voiceButton.hidden = YES;
    }
}




@end
