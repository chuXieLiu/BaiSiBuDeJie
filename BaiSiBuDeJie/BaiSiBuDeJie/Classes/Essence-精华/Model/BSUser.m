//
//  BSUser.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/16.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSUser.h"

@interface BSUser ()<YYModel>

@end

@implementation BSUser

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"profileImage" : @"profile_image"
             };
}

@end
