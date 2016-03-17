//
//  BSVoiceView.h
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/16.
//  Copyright © 2016年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BSTopic;

@interface BSTopicVoiceView : UIView

+ (instancetype)voiceView;

@property (nonatomic,strong) BSTopic *topic;

@end
