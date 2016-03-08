//
//  NSObject+BSModel.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/8.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "NSObject+BSModel.h"

@implementation NSObject (BSModel)

+ (id)bs_modelWithDictionary:(NSDictionary *)dict
{
    if (dict) return [self yy_modelWithDictionary:dict];
    return [self new];
}

+ (id)bs_modelWithDictionaryList:(NSArray<NSDictionary *> *)list
{
    if (list) {
        NSMutableArray *array = @[].mutableCopy;
        for (NSDictionary *dict in list) {
            [array addObject:[self bs_modelWithDictionary:dict]];
        }
        return array.copy;
    }
    return @[].mutableCopy;
}



@end
