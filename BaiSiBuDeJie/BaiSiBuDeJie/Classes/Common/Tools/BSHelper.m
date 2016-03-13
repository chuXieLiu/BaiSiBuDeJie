//
//  BSHelper.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/12.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSHelper.h"

@implementation BSHelper

+ (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *frmt = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        frmt = [[NSDateFormatter alloc] init];
        frmt.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    });
    return frmt;
}

@end
