//
//  BSEssenceTopicView.h
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/11.
//  Copyright © 2016年 CX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BSEssenceTopicView;

@protocol BSEssenceTopicViewDelegate <NSObject>

- (void)essenceTopicView:(UIView *)topicView didSelectedIndex:(NSInteger)index;

@end


@interface BSEssenceTopicView : UIView

- (instancetype)initWithTopics:(NSArray <NSString *>*)topics
                      delegate:(id <BSEssenceTopicViewDelegate>)delegate;

@property (nonatomic,assign,readonly) NSInteger currentIndex;

- (void)setSelectTopic:(NSInteger)index animated:(BOOL)animated;


@property (nonatomic,weak) id<BSEssenceTopicViewDelegate> delegate;

@property (nonatomic,strong) NSArray *topics;

@end
