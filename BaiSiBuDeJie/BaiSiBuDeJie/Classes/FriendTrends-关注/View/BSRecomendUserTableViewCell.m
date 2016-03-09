//
//  BSRecomendUserTableViewCell.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/8.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSRecomendUserTableViewCell.h"
#import <UIImageView+WebCache.h>
#import <SDWebImageManager.h>
#import "BSRecomendUser.h"
#import "UIImage+BS.h"
#import <UIImageView+AFNetworking.h>

@interface BSRecomendUserTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation BSRecomendUserTableViewCell

- (void)awakeFromNib {
    _iconView.layer.cornerRadius = _iconView.width * 0.5;
    _iconView.layer.masksToBounds = YES;
    _iconView.layer.shouldRasterize = YES;
    _iconView.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)setUser:(BSRecomendUser *)user
{
    _user = user;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:_user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    _nameLabel.text = _user.name;
    _fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注",_user.fansCount];
}

@end
