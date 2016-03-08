//
//  BSAPIClient.h
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/8.
//  Copyright © 2016年 CX. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface BSAPIClient : AFHTTPSessionManager

+ (instancetype)shareManager;

@end
