//
//  BSTopic.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/11.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSTopic.h"
#import "NSDate+BSExtension.h"



@interface BSTopic () <YYModel>

@property (nonatomic,assign,readwrite) CGFloat cellHeight;

@end

@implementation BSTopic



- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        _cellHeight += kBSTopicCellIconHeight +  2 *kBSTopicCellMargin; // icon头像
        CGFloat maxW = BS_SCREEN_WIDTH - 4 * kBSTopicCellMargin;
        CGSize size = CGSizeMake( maxW, MAXFLOAT);
        CGFloat textHeight = [_text boundingRectWithSize:size
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:[self textAttributes]
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
        }
        
        _cellHeight += kBSTopicCellToolBarheight + kBSTopicCellMargin; // 工具条+setFrame减去的高度
        
        return _cellHeight;
    }
    return _cellHeight;
}


- (NSAttributedString *)attributeText
{
    if (!_attributeText) {
        _attributeText = [[NSAttributedString alloc] initWithString:_text attributes:[self textAttributes]].mutableCopy;
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





- (NSDictionary *)textAttributes
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5;
    return  @{
              NSParagraphStyleAttributeName : style,
              NSFontAttributeName : [UIFont systemFontOfSize:16.0f]
              };
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
             };
}























@end
