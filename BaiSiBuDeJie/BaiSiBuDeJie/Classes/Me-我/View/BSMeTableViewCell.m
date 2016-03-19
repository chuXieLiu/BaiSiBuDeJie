//
//  BSMeTableViewCell.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/19.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSMeTableViewCell.h"

@implementation BSMeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgView;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (!self.imageView.image) {
        return;
    }
    
    self.imageView.left = 10.0f;
    self.imageView.width = 30.0f;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.contentView.centerY;
    
    
    self.textLabel.left = self.imageView.right + 10.0f;
}



@end
