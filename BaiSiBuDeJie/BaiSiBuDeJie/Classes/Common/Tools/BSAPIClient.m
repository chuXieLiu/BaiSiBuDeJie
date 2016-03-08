//
//  BSAPIClient.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/8.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSAPIClient.h"

static NSTimeInterval const BSAPIRequestTimeOut = 30.0f;

@implementation BSAPIClient

+ (instancetype)shareManager
{
    static BSAPIClient *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:kBSAPIBaseURLString]];
        _instance.requestSerializer.timeoutInterval = BSAPIRequestTimeOut;
        _instance.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    return _instance;
}

@end
