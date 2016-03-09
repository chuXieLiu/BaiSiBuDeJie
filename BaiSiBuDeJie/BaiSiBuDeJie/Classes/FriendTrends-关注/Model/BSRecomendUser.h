//
//  BSRecomendUser.h
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/8.
//  Copyright © 2016年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BSRecommendCategory;

@interface BSRecomendUser : NSObject

@property (nonatomic,copy) NSString *header;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger fansCount;

+ (NSURLSessionTask *)loadRecommendUsersWithCategory:(BSRecommendCategory *)category
                                               Block:(void (^) (NSArray *users , NSInteger total, NSError *error))block;



@end
