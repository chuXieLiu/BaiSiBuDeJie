//
//  BSComment.h
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/16.
//  Copyright © 2016年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BSLoadCommentBlock)(NSArray *comments,NSArray *hots, NSInteger total,NSError *error);

@class BSUser;

@interface BSComment : NSObject

@property (nonatomic,assign) NSInteger commentId;

@property (nonatomic, assign) NSInteger voicetime; // 音频文件的时长

@property (nonatomic, copy) NSString *voiceuri;     // 音频路径

@property (nonatomic, copy) NSString *content;  //评论的文字内容

@property (nonatomic,copy) NSAttributedString *attributeTopContent;

@property (nonatomic,copy) NSAttributedString *attributeContent;

@property (nonatomic, assign) NSInteger likeCount;

@property (nonatomic, strong) BSUser *user;

@property (nonatomic,assign,readonly) CGFloat cellHeight;



+ (NSURLSessionTask *)loadNewCommentWithTopicId:(NSInteger)topicId block:(BSLoadCommentBlock)block;



+ (NSURLSessionTask *)loadMoreCommentWithTopicId:(NSInteger)topicId lastCommentId:(NSInteger)commentId page:(NSInteger)page block:(BSLoadCommentBlock)block;











@end
