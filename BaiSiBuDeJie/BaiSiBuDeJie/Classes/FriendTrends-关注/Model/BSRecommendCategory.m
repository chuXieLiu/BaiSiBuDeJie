//
//  BSRecommendCategory.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/8.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSRecommendCategory.h"


@implementation BSRecommendCategory


- (NSMutableArray *)users
{
    if (_users == nil) {
        _users = @[].mutableCopy;
    }
    return _users;
}


@end
