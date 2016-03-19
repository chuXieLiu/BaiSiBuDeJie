//
//  UIImageView+BSExtension.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/19.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "UIImageView+BSExtension.h"
#import <UIImageView+WebCache.h>
#import "UIImage+BS.h"

@implementation UIImageView (BSExtension)

- (void)setHeader:(NSString *)url
{
    if (url) {
        UIImage *placeHplderImage = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
        [self sd_setImageWithURL:[NSURL URLWithString:url]
                placeholderImage:placeHplderImage
        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.image = image ?  [image circleImage] : placeHplderImage;
        }];
    }
}


@end
