//
//  BSTopic.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/11.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSTopic.h"

@interface BSTopic () <YYModel>

@end

@implementation BSTopic

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"profileImage" : @"profile_image",
             @"screenName" : @"screen_name",
             @"createTime" : @"create_time",
             @"" : @"",
             };
}

@end
