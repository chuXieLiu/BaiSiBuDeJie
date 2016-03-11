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

@interface BSTopicTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *dingButton;

@property (weak, nonatomic) IBOutlet UIButton *caiButton;

@property (weak, nonatomic) IBOutlet UIButton *repostButton;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation BSTopicTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
}

- (void)setFrame:(CGRect)frame
{
    self.left = kBSTopicCellMargin;
    self.width = 2 * kBSTopicCellMargin;
    self.top = kBSTopicCellMargin;
    self.height -= kBSTopicCellMargin;
    [super setFrame:frame];
}

- (void)setTopic:(BSTopic *)topic
{
    _topic = topic;
    [_profileImageView sd_setImageWithURL:[NSURL URLWithString:_topic.profileImage] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    _screenNameLabel.text = _topic.screenName;
    _createTimeLabel.text = _topic.createTime;
    
    
    
}


@end
