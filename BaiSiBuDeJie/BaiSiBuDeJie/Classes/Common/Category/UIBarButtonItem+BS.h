//
//  UIBarButtonItem+BS.h
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/7.
//  Copyright © 2016年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BS)

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title image:(NSString *)norImage selectImage:(NSString *)selectImage target:(id)target action:(SEL)action;

@end
