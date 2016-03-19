//
//  BSMeFooterView.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/19.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSMeFooterView.h"
#import "BSSquare.h"
#import "BSMeFooterButton.h"

static NSString * const KBSMeParmsAValue = @"square";
static NSString * const KBSMeParmsCValue = @"topic";

static NSString * const kBSMeFooterBaseURL = @"http://api.budejie.com/api/api_open.php";

static NSString * const kBSMeAPIResponseKeySquare_list = @"square_list";

@implementation BSMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[kBSAPIParamsKeyA] = KBSMeParmsAValue;
        params[kBSAPIParamsKeyC] = KBSMeParmsCValue;
        @weakify(self)
        [[BSAPIClient shareManager] GET:kBSMeFooterBaseURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            @strongify(self)
            if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
                [self createSquare:[BSSquare bs_modelWithDictionaryList:responseObject[kBSMeAPIResponseKeySquare_list]]];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            BSLog(@"%@",error);
        }];
    
    }
    return self;
}

- (void)createSquare:(NSArray *)squares
{
    NSInteger count = squares.count;
    NSInteger maxCol = 4;
    
    CGFloat width = BS_SCREEN_WIDTH / maxCol;
    CGFloat height = width;
    
    CGFloat x = 0;
    CGFloat y = 0;
    
    for (NSInteger i = 0; i < count; i++) {
        BSMeFooterButton *button = [[BSMeFooterButton alloc] init];
        button.square = squares[i];
        
        NSInteger row = i / maxCol;
        NSInteger col = i % maxCol;
        
        x = col * width;
        y = row * height;
        
        button.frame = CGRectMake(x, y, width, height);
        [self addSubview:button];
        
    }
    
    NSUInteger rows = (count + maxCol - 1) / maxCol;
    
    self.height = rows * height;

    !self.layoutCompletionBlock ? : self.layoutCompletionBlock();

}

















@end
