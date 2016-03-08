//
//  BSRecommendCategory.h
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/8.
//  Copyright © 2016年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSRecommendCategory : NSObject

@property (nonatomic,assign) NSInteger count;
@property (nonatomic,assign) NSInteger id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign) NSInteger total;
@property (nonatomic,strong) NSMutableArray *users;

@end
