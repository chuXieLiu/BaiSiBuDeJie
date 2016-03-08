//
//  NSObject+BSModel.h
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/8.
//  Copyright © 2016年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>

@interface NSObject (BSModel)

+ (id)bs_modelWithDictionary:(NSDictionary *)dict;
+ (id)bs_modelWithDictionaryList:(NSArray <NSDictionary *>*) list;

@end
