//
//  BSCommentHeaderView.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/16.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSCommentHeaderView.h"

static NSString * const KBSCommentHederViewIdentifier = @"KBSCommentHederViewIdentifier";

@interface BSCommentHeaderView ()

@property (nonatomic,weak) UILabel *titleLabel;

@end

@implementation BSCommentHeaderView

+ (instancetype)commentHeaderViewWithTableView:(UITableView *)tableView
{
    BSCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:KBSCommentHederViewIdentifier];
    if (!header) {
        header = [[BSCommentHeaderView alloc] initWithReuseIdentifier:KBSCommentHederViewIdentifier];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.textColor = BS_RGBAColor(67, 67, 67, 1.0);
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        label.left = kBSTopicCellMargin;
        label.width = 200.0f;
        [self.contentView addSubview:label];
        self.contentView.backgroundColor = BS_RGBAColor(233, 233, 233, 1.0);
        _titleLabel = label;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title.copy;
    _titleLabel.text = title;
}



@end
