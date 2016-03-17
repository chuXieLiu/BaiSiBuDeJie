//
//  BSTopic.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/11.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSTopic.h"
#import "NSDate+BSExtension.h"
#import "BSUser.h"
#import "BSComment.h"



static NSString * const kBSTopicParamsKeyType = @"type";

static NSString * const kBSTopicParamsKeyPage = @"page";

static NSString * const kBSTopicParamsKeyMaxTime = @"maxtime";


static NSString * const kBSTopicParamsKeyAValue = @"list";
static NSString * const kBSTopicParamsKeyCValue = @"data";


static NSString * const kBSTopicResponseKeyMaxTime = @"maxtime";



@interface BSTopic () <YYModel>

@property (nonatomic,assign,readwrite) CGFloat cellHeight;

@end

@implementation BSTopic

+ (NSURLSessionTask *)loadNewTopicsWithType:(NSInteger)type Block:(void (^)(NSArray *, NSString *,NSError *))block
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[kBSAPIParamsKeyA] = kBSTopicParamsKeyAValue;
    params[kBSAPIParamsKeyC] = kBSTopicParamsKeyCValue;
    params[kBSTopicParamsKeyType] = @(type);
    return [self loadTopicWithParams:params block:block];
}

+ (NSURLSessionTask *)loadMoreOldTopicsWithType:(NSInteger)type page:(NSInteger)page maxTime:(NSString *)maxTime block:(void (^)(NSArray *, NSString *, NSError *))block
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[kBSAPIParamsKeyA] = kBSTopicParamsKeyAValue;
    params[kBSAPIParamsKeyC] = kBSTopicParamsKeyCValue;
    params[kBSTopicParamsKeyType] = @(type);
    params[kBSTopicParamsKeyPage] = @(page);
    params[kBSTopicParamsKeyMaxTime] = maxTime;
    return [self loadTopicWithParams:params block:block];
}

+ (NSURLSessionTask *)loadTopicWithParams:(NSDictionary *)params block:(void (^) (NSArray *topics , NSString *maxTime , NSError *error))block
{
    return [[BSAPIClient shareManager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (block) {
            NSArray *list = [BSTopic bs_modelWithDictionaryList:responseObject[kBSAPIResponseKeyList]];
            NSString *maxTime = responseObject[kBSAPIResponseKeyInfo][kBSTopicResponseKeyMaxTime];
            block(list,maxTime,nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(@[],nil,error);
        }
    }];
}



- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        _cellHeight += kBSTopicCellIconHeight +  2 *kBSTopicCellMargin; // icon头像
        CGFloat maxW = BS_SCREEN_WIDTH - 4 * kBSTopicCellMargin;
        CGSize size = CGSizeMake(maxW, MAXFLOAT);
        CGFloat textHeight = [self.attributeText boundingRectWithSize:size
                                                              options:NSStringDrawingUsesLineFragmentOrigin
                                                              context:nil].size.height;
        _cellHeight += textHeight + kBSTopicCellMargin;    // 文字
        
        if (self.type == BSEssenceTopicTypePicture) {
            CGFloat pictureW = maxW;
            CGFloat pictureH = floorf(pictureW * _height / _width);
            if (pictureH > kBSTopicCellMaxPictureHeight) {
                _isLongPicture = YES;
                pictureH = kBSTopicCellBreakPictureHeight;
            }
            _pictureFrame = CGRectMake(kBSTopicCellMargin, _cellHeight, pictureW, pictureH);
            _cellHeight += pictureH + kBSTopicCellMargin;   // 图片
        } else if (self.type == BSEssenceTopicTypeVoice || self.type == BSEssenceTopicTypeVideo) {
            CGFloat pictureW = maxW;
            CGFloat pictureH = floorf(pictureW * _height / _width);
            if (pictureH > kBSTopicCellMaxPictureHeight) {
                pictureH = kBSTopicCellBreakPictureHeight;
            }
            _pictureFrame = CGRectMake(kBSTopicCellMargin, _cellHeight, pictureW, pictureH);
            _cellHeight += pictureH + kBSTopicCellMargin;   // 图片
        }
        
        BSComment *comment = _topCmt.firstObject;
        if (comment) {
            CGFloat height = [comment.attributeTopContent boundingRectWithSize:size
                                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                                    context:nil].size.height;
            _cellHeight += (kBSTopicCellTopCommentTitleHeight +kBSTopicCellTopCommentMargin + height + kBSTopicCellMargin);
        }
        
        _cellHeight += kBSTopicCellToolBarheight + kBSTopicCellMargin; // 工具条+setFrame减去的高度
        
        return _cellHeight;
    }
    return _cellHeight;
}


- (NSAttributedString *)attributeText
{
    if (!_attributeText) {
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 5;
        NSDictionary *attr =  @{
                  NSParagraphStyleAttributeName : style,
                  NSFontAttributeName : [UIFont systemFontOfSize:16.0f]
                  };
        _attributeText = [[NSAttributedString alloc] initWithString:_text attributes:attr].copy;
    }
    return _attributeText;
}





- (NSString *)createTime
{
    NSDateFormatter *frmt = [BSHelper dateFormatter];
    // 2016-03-11 20:56:01
    [frmt setDateFormat:@"yyyy-MM-dd HH:mmm:ss"];
    NSDate *date = [frmt dateFromString:_createTime];
    if ([date isThisYear]) { // 今年
        if ([date isToday]) {
            NSDateComponents *components = [[NSDate date] deltaFrom:date];
            if (components.hour >= 1) { // 1小时前
                return [NSString stringWithFormat:@"%zd小时前",components.hour];
            } else if (components.minute >= 1) {    // 1小时内
                return [NSString stringWithFormat:@"%zd分钟前",components.minute];
            } else {    // 1分钟内
                return @"刚刚";
            }
        } else if ([date isYesterday]){ // 昨天
            [frmt setDateFormat:@"昨天 HH:mm:ss"];
            return [frmt stringFromDate:date];
        } else {
            [frmt setDateFormat:@"MM-dd HH:mm:ss"];
            return [frmt stringFromDate:date];
        }
    } else {
        return _createTime;
    }
}






+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"profileImage" : @"profile_image",
             @"screenName" : @"screen_name",
             @"createTime" : @"create_time",
             @"smallImage" : @"image0",
             @"middleImage" : @"image1",
             @"largeImage" : @"image2",
             @"isGif" : @"is_gif",
             @"topCmt" : @"top_cmt",
             @"topicId" : @"id"
             };
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"topCmt" : [BSComment class]
                 
                 };
}






















@end
