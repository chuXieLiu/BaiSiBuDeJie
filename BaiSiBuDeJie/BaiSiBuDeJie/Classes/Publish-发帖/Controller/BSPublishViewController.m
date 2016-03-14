//
//  BSPublishViewController.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/14.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSPublishViewController.h"
#import "BSVerticalButton.h"

@interface BSPublishViewController ()

@end

@implementation BSPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:sloganView];
    sloganView.top = BS_SCREEN_HEIGHT * 0.15;
    sloganView.centerX = BS_SCREEN_WIDTH * 0.5;
    
    
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    NSInteger count = images.count;

    NSInteger maxCol = 3;   // 一行多少列
    
    CGFloat verticalMargin = 10.0f;  // icon垂直间距
    
    CGFloat buttonW = 72.0f;
    CGFloat buttonH = 72.0f + 40.0f;
    
    CGFloat startY = (BS_SCREEN_HEIGHT - (2 * buttonH) - ((count / maxCol) - 1) * verticalMargin) * 0.5;  // 起始Y值
    
    CGFloat leftMargin = 20.0f; // 左边间隙
    CGFloat horizontalMargin = (BS_SCREEN_WIDTH - 2 * leftMargin - maxCol * buttonW) / (maxCol - 1); // icon水平间距
    
    
    for (int i = 0; i < images.count; i++) {
        BSVerticalButton *button = [[BSVerticalButton alloc] init];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.view addSubview:button];
        
        int row = i / maxCol;   // 行
        int col = i % maxCol;   // 列
        
        CGFloat buttonX = leftMargin + (buttonW + horizontalMargin) * col;
        CGFloat buttonY = startY + (buttonH + verticalMargin) * row;
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
    }
    
    
    
}


- (IBAction)cancel:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
