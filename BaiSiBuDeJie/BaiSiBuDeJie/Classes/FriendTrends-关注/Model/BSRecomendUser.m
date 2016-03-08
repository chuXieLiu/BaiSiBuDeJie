//
//  BSRecomendUser.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/8.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSRecomendUser.h"
#import <YYModel.h>

@interface BSRecomendUser () <YYModel>

@end

@implementation BSRecomendUser

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"name" : @"screen_name",
             @"fansCount" :  @"fans_count",
             };
}


@end
