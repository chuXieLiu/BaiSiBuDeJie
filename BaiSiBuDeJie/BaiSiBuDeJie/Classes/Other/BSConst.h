//
//  BSConst.h
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/8.
//  Copyright © 2016年 CX. All rights reserved.
//


typedef enum : NSUInteger {
    BSEssenceTopicTypeAll = 1,
    BSEssenceTopicTypeVideo = 41,
    BSEssenceTopicTypePicture = 10,
    BSEssenceTopicTypeWord = 29,
    BSEssenceTopicTypeVoice = 31
} BSEssenceTopicType;


// networking

UIKIT_EXTERN NSString * const kBSAPIBaseURLString;

UIKIT_EXTERN NSString * const kBSAPIResponseErrorString;

UIKIT_EXTERN NSString * const kBSAPIParamsKeyA;

UIKIT_EXTERN NSString * const kBSAPIParamsKeyC;

UIKIT_EXTERN NSString * const kBSAPIResponseKeyInfo;

UIKIT_EXTERN NSString * const kBSAPIResponseKeyList;

UIKIT_EXTERN NSString * const kBSAPIResponsekeyTotal;






// topic

UIKIT_EXTERN CGFloat const kBSEssenceTopicViewHeight;

UIKIT_EXTERN CGFloat const kBSTabBarHeight;

UIKIT_EXTERN CGFloat const kBSNavigationBarHeight;

UIKIT_EXTERN CGFloat const kBSTopicCellMargin;

UIKIT_EXTERN CGFloat const kBSTopicCellIconHeight;

UIKIT_EXTERN CGFloat const kBSTopicCellToolBarheight;

UIKIT_EXTERN CGFloat const kBSTopicCellMaxPictureHeight;

UIKIT_EXTERN CGFloat const kBSTopicCellBreakPictureHeight;

UIKIT_EXTERN CGFloat const kBSTopicCellTopCommentTitleHeight;

UIKIT_EXTERN CGFloat const kBSTopicCellTopCommentMargin; // 标题与内容的间距



// 男
UIKIT_EXTERN NSString * const kBSUserSexMan;
// 女
UIKIT_EXTERN NSString * const kBSUserSexFemale;







