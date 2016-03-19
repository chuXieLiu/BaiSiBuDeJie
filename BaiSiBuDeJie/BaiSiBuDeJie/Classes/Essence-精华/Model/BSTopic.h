//
//  BSTopic.h
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/11.
//  Copyright © 2016年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BSTopic : NSObject

@property (nonatomic,assign) NSInteger topicId;

@property (nonatomic,copy) NSString *profileImage;

@property (nonatomic,copy) NSString *screenName;

@property (nonatomic,copy) NSString *createTime;

@property (nonatomic,copy) NSString *text;

@property (nonatomic,copy) NSAttributedString *attributeText;

@property (nonatomic,copy) NSString *smallImage;

@property (nonatomic,copy) NSString *middleImage;

@property (nonatomic,copy) NSString *largeImage;

@property (nonatomic,assign) CGRect pictureFrame;

@property (nonatomic,assign) CGFloat progress;

@property (nonatomic,assign) CGFloat width;

@property (nonatomic,assign) CGFloat height;

@property (nonatomic,assign) BOOL isGif;

@property (nonatomic,assign) BOOL isLongPicture; // 是否为长图

@property (nonatomic,copy) NSString *voiceuri;

@property (nonatomic,assign) NSInteger voicetime;

@property (nonatomic,copy) NSString *videouri;

@property (nonatomic,assign) NSInteger videotime;

@property (nonatomic, assign) NSInteger playcount;  // 播放次数

@property (nonatomic,strong) NSArray *topCmt;   // 最热评论

@property (nonatomic,assign) NSInteger ding;    // 顶

@property (nonatomic,assign) NSInteger cai;     // 踩

@property (nonatomic,assign) NSInteger comment; // 评论

@property (nonatomic,assign) NSInteger repost;  // 转发

@property (nonatomic,assign) BSEssenceTopicType type;

@property (nonatomic,assign,readonly) CGFloat cellHeight;



+ (NSURLSessionTask *)loadNewTopicsWithModule:(BSTopicModule)module type:(NSInteger)type Block:(void (^) (NSArray *topics , NSString *maxTime , NSError *error))block;

+ (NSURLSessionTask *)loadMoreOldTopicsWithModule:(BSTopicModule)module type:(NSInteger)type page:(NSInteger)page maxTime:(NSString *)maxTime block:(void (^) (NSArray *topics , NSString *maxTime , NSError *error))block;








@end
