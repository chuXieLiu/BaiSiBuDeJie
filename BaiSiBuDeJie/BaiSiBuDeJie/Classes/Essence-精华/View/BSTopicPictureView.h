//
//  BSTopicPictureView.h
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/12.
//  Copyright © 2016年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSTopic;

@interface BSTopicPictureView : UIView

@property (nonatomic,strong) BSTopic *topic;

+ (instancetype)topicPictureView;


@end
