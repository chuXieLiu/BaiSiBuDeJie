//
//  BSComment.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/16.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSComment.h"
#import "BSUser.h"

static NSString * const kBSCommentBaseURL = @"http://api.budejie.com/api/api_open.php";

static NSString * const kBSCommentParamKeyDataID = @"data_id";

static NSString * const kBSCommentParamKeyHot = @"hot";

static NSString * const kBSCommentParamKeyPage = @"page";

static NSString * const kBSCommentParamKeyLastId = @"lastcid";



static NSString * const kBSCommentParamAValue = @"dataList";

static NSString * const kBSCommentParamCValue = @"comment";

static NSString * const kBSCommentParamHotValue = @"1";



static NSString * const kBSCommentResponseKeyData = @"data";

static NSString * const kBSCommentResponseKeyHot = @"hot";

@interface BSComment () <YYModel>

@property (nonatomic,assign,readwrite) CGFloat cellHeight;

@end


@implementation BSComment

+ (NSURLSessionTask *)loadNewCommentWithTopicId:(NSInteger)topicId block:(BSLoadCommentBlock)block
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[kBSAPIParamsKeyA] = kBSCommentParamAValue;
    params[kBSAPIParamsKeyC] = kBSCommentParamCValue;
    params[kBSCommentParamKeyDataID] = @(topicId);
    params[kBSCommentParamKeyHot] = kBSCommentParamHotValue;
    return [self loadCommentWithParams:params Block:block];
}

+ (NSURLSessionTask *)loadMoreCommentWithTopicId:(NSInteger)topicId lastCommentId:(NSInteger)commentId page:(NSInteger)page block:(BSLoadCommentBlock)block
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[kBSAPIParamsKeyA] = kBSCommentParamAValue;
    params[kBSAPIParamsKeyC] = kBSCommentParamCValue;
    params[kBSCommentParamKeyDataID] = @(topicId);
    params[kBSCommentParamKeyPage] = @(page);
    params[kBSCommentParamKeyLastId] = @(commentId);
    return [self loadCommentWithParams:params Block:block];
}

+ (NSURLSessionTask *)loadCommentWithParams:(NSDictionary *)params Block:(BSLoadCommentBlock)block
{
    return [[BSAPIClient shareManager] GET:kBSCommentBaseURL
                                parameters:params
                                  progress:nil
        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *data = responseObject[kBSCommentResponseKeyData];
            if (data) {
                if (block) {
                    NSArray *list = [BSComment bs_modelWithDictionaryList:data];
                    NSArray *hotList = [BSComment bs_modelWithDictionaryList:responseObject[kBSCommentResponseKeyHot]];
                    NSInteger total = [responseObject[kBSAPIResponsekeyTotal] integerValue];
                    block(list,hotList,total,nil);
                }
            } else {
                !block ? : block(nil,nil,0,nil);
            }
        } else {
            !block ? : block(nil,nil,0,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        !block ? : block(nil,nil,0,error);
    }];
}







+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"likeCount" : @"like_count",
             @"commentId" : @"id"
             };
}

- (NSAttributedString *)attributeTopContent
{
    if (_attributeTopContent == nil) {
        NSString *content = [NSString stringWithFormat:@"%@: %@",_user.username,_content];
        _attributeTopContent = [[NSAttributedString alloc] initWithString:content
                                                            attributes:[self attribute]];
    }
    return _attributeTopContent;
}

- (NSAttributedString *)attributeContent
{
    if (_attributeContent == nil) {
        _attributeContent = [[NSAttributedString alloc] initWithString:_content
                                                            attributes:[self attribute]];
    }
    return _attributeContent;
}

- (NSDictionary *)attribute
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5;
    return  @{
                            NSParagraphStyleAttributeName : style,
                            NSFontAttributeName : [UIFont systemFontOfSize:15.0f]
                            };
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        _cellHeight += kBSTopicCellMargin;
        _cellHeight += 16.0f;   // 昵称label高度
        _cellHeight += kBSTopicCellMargin;
        if (self.voiceuri.length) {
            _cellHeight += 22;   // button 高度
        } else {
            CGFloat maxW = BS_SCREEN_WIDTH - 4 * kBSTopicCellMargin - 35.0 - 15.0 - kBSTopicCellIconHeight;    // 点赞label宽度、与边框的距离，icon宽度，setFrame减去两个宽度
            CGFloat height = [self.attributeContent boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
            _cellHeight += height;
        }
        _cellHeight += kBSTopicCellMargin;
    }
    return _cellHeight;
}



@end
