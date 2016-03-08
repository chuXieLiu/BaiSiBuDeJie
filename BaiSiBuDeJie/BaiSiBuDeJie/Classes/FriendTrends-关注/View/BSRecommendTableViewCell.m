//
//  BSRecommendTableViewCell.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/8.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSRecommendTableViewCell.h"
#import "BSRecommendCategory.h"

@interface BSRecommendTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *categoryIndicator;


@end

@implementation BSRecommendTableViewCell

- (void)awakeFromNib {
    
}

- (void)setRecommendCategory:(BSRecommendCategory *)recommendCategory
{
    _recommendCategory = recommendCategory;
    self.textLabel.text = recommendCategory.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.height -=1;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.categoryIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.categoryIndicator.backgroundColor : BS_RGBAColor(78, 78, 78, 1.0);
    self.backgroundColor = selected ? [UIColor whiteColor] : BS_RGBAColor(241, 241, 241, 1.0);
}


@end
