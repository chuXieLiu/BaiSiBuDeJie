//
//  BSRecommendCategory.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/8.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSRecommendCategory.h"


static NSString * const kBSCategoryParamsKeyA = @"a";
static NSString * const kBSCategoryParamsKeyC = @"c";

static NSString * const kBSCategoryParamsKeyAValue = @"category";
static NSString * const kBSCategoryParamsKeyCValue = @"subscribe";


static NSString * const kBSCategoryResponseKeyList = @"list";


@implementation BSRecommendCategory


- (NSMutableArray *)users
{
    if (_users == nil) {
        _users = @[].mutableCopy;
    }
    return _users;
}



+ (NSURLSessionTask *)loadRecommendCategoriesBlock:(void (^)(NSArray *, NSError *))block
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[kBSCategoryParamsKeyA] = kBSCategoryParamsKeyAValue;
    params[kBSCategoryParamsKeyC] = kBSCategoryParamsKeyCValue;
    return [[BSAPIClient shareManager] GET:kBSAPIBaseURLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (block) {
            NSArray *list = [BSRecommendCategory bs_modelWithDictionaryList:responseObject[kBSCategoryResponseKeyList]];
            block (list,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(nil,error);
        }
    }];
}






@end





