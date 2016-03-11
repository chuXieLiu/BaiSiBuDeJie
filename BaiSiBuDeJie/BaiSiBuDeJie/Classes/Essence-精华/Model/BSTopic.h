//
//  BSTopic.h
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/11.
//  Copyright © 2016年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSTopic : NSObject

@property (nonatomic,copy) NSString *profileImage;

@property (nonatomic,copy) NSString *screenName;

@property (nonatomic,copy) NSString *createTime;

@property (nonatomic,copy) NSString *text;

@property (nonatomic,assign) NSInteger ding;    // 顶

@property (nonatomic,assign) NSInteger cai;     // 踩

@property (nonatomic,assign) NSInteger comment; // 评论

@property (nonatomic,assign) NSInteger repost;  // 转发





@end
