//
//  BSPublishViewController.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/14.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSPublishViewController.h"
#import "BSVerticalButton.h"
#import <POP.h>

static CFTimeInterval const kBSAnimationDuration = 0.1f;

@interface BSPublishViewController ()

@property (weak, nonatomic) IBOutlet UIButton *cacelButton;

@property (nonatomic,weak) UIImageView *slogan;

@end

@implementation BSPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    NSInteger count = images.count;

    NSInteger maxCol = 3;   // 一行多少列
    
    CGFloat verticalMargin = 10.0f;  // icon垂直间距
    
    CGFloat buttonW = 72.0f;
    CGFloat buttonH = 72.0f + 40.0f;
    
    CGFloat startY = (BS_SCREEN_HEIGHT - (2 * buttonH) - ((count / maxCol) - 1) * verticalMargin) * 0.5 + (BS_SCREEN_HEIGHT * 0.05);  // 起始Y值 + 偏移量
    
    CGFloat leftMargin = 20.0f; // 左边间隙
    CGFloat horizontalMargin = (BS_SCREEN_WIDTH - 2 * leftMargin - maxCol * buttonW) / (maxCol - 1); // icon水平间距
    
    self.view.userInteractionEnabled = NO;
    
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
        
        int newI = (count - 1 - i);
        
        int newRow = newI / maxCol;
        
        int midleCol = maxCol / 2;   // 中间一列
        
        CGFloat start = 0.f;
        
        /*
         0 1 2
         
         0-     0   2   0.4         1-    5,4,3   (1 + 1) * 0.2
                1     0.3                      (4 - 1 )* 0.2 / 2
         1-     3   5   0.2         0-    2,1,0    (0 + 1) * 0.2
                4     0.1                      (1 - 1) * 0.2/ 2
        
        */
        if (col == midleCol) { // 第二列
            start = MAX(newI - 1, 1) * (kBSAnimationDuration * 0.5);
        } else {
            start = (newRow + 1) * kBSAnimationDuration;
        } 

        CGRect fromRect = CGRectMake(buttonX, buttonY - BS_SCREEN_HEIGHT, buttonW, buttonH);
        CGRect toRect = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.springBounciness = 5;
        animation.springSpeed = 10;
        animation.fromValue = [NSValue valueWithCGRect:fromRect];
        animation.toValue = [NSValue valueWithCGRect:toRect];
        animation.beginTime = CACurrentMediaTime() + start;
        [button pop_addAnimation:animation forKey:nil];
        button.tag = newI + 1;
    }
    
    
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    _slogan = sloganView;
    [self.view addSubview:sloganView];
    CGFloat centerX = BS_SCREEN_WIDTH * 0.5;
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.springBounciness = 5;
    anim.springSpeed = 5;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, -BS_SCREEN_HEIGHT)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX,BS_SCREEN_HEIGHT * 0.2)];
    anim.beginTime = CACurrentMediaTime() + (count * 0.5 - 1) * kBSAnimationDuration;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        self.view.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];
    
}

- (void)cancelBlock:(void (^) ())block
{
    /*
           0   1   2
     
     1-    5,  4,   3
     
           0.6 0.4 0.5
     
     0-    2,  1,   0
     
           0.3 0.1 0.2
     
     */
    
    self.view.userInteractionEnabled = NO;
    
    int count = 6;
    int maxCol = 3;
    int midleCol = maxCol * 0.5;
    
    for (int i = count; i > 0; i --) {
        UIButton *button = [self.view viewWithTag:i];
        int col = (count - i) % maxCol;
        CGFloat start = 0.f;
        
        int newI = (i - 1);
        if (col == midleCol) {
            start = newI * (kBSAnimationDuration * 0.5);
        } else {
            start = (MAX(col, 1) + newI) * (kBSAnimationDuration * 0.5);
        }
        
        POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
//        POPBasicAnimation *animation = [POPBasicAnimation easeOutAnimation];
        animation.property = [POPAnimatableProperty propertyWithName:kPOPViewCenter];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(button.centerX, button.centerY + BS_SCREEN_HEIGHT)];
        animation.beginTime = CACurrentMediaTime() + start;
        [button pop_addAnimation:animation forKey:nil];
        
    }
    
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(_slogan.centerX, _slogan.centerY + BS_SCREEN_HEIGHT)];
    anim.beginTime = CACurrentMediaTime() + count * (kBSAnimationDuration * 0.5) ;
    [anim setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        self.view.userInteractionEnabled = YES;
        !block ? : block();
    }];
    [_slogan pop_addAnimation:anim forKey:nil];
}


- (IBAction)cancel:(UIButton *)sender {
    sender.hidden = YES;
    [self cancelBlock:^{
       [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancel:nil];
}


@end
