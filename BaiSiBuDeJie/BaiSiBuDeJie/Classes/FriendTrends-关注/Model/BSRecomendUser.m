//
//  BSRecomendUser.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/8.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSRecomendUser.h"
#import "BSRecommendCategory.h"
#import <YYModel.h>



static NSString * const kBSUserParamsKeyCategoryid = @"category_id";
static NSString * const kBSUserParamsKeyPage = @"page";

static NSString * const kBSUserParamsKeyAValue = @"list";
static NSString * const kBSUserParamsKeyCValue = @"subscribe";


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

+ (NSURLSessionTask *)loadRecommendUsersWithCategory:(BSRecommendCategory *)category Block:(void (^)(NSArray *, NSInteger, NSError *))block
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[kBSAPIParamsKeyA] = kBSUserParamsKeyAValue;
    params[kBSAPIParamsKeyC] = kBSUserParamsKeyCValue;
    if (category.id) params[kBSUserParamsKeyCategoryid] = @(category.id);
    if (category.currentPage) params[kBSUserParamsKeyPage] = @(category.currentPage);
    return [[BSAPIClient shareManager] GET:kBSAPIBaseURLString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *list = [BSRecomendUser bs_modelWithDictionaryList:responseObject[kBSAPIResponseKeyList]];
        NSInteger total = [responseObject[kBSAPIResponsekeyTotal] integerValue];
        if (block) {
            block(list,total,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(nil,0,error);
        }
    }];
}


@end
