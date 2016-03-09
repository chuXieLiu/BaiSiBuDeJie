//
//  BSTrendsViewController.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/7.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSTrendsViewController.h"
#import "UIBarButtonItem+BS.h"
#import "BSRecommendViewController.h"
#import "BSLoginViewController.h"


@interface BSTrendsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *introLabel;

@end

@implementation BSTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BS_RGBAColor(233, 233, 233, 1.0);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:nil
                                                                     image:@"friendsRecommentIcon"
                                                               selectImage:@"friendsRecommentIcon-click"
                                                                    target:self
                                                                    action:@selector(recommendEvent:)];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 10.0f;
    style.alignment = NSTextAlignmentCenter;
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"快快登录吧，关注百思最ing牛人\n好友动态让你过吧瘾儿~\n噢耶~~~~！"
            attributes:@{
                         NSForegroundColorAttributeName : BS_RGBAColor(143, 143, 143, 1),
                         NSParagraphStyleAttributeName  : style
                                                                                            }];
    _introLabel.attributedText = string;
    
}

- (IBAction)loginAndRegister:(UIButton *)sender {
    UIViewController *loginVC = [[BSLoginViewController alloc] init];
    [self presentViewController:loginVC animated:YES completion:nil];
}


#pragma mark - target event

- (void)recommendEvent:(UIBarButtonItem *)sender
{
    BSRecommendViewController *recommendVC = [BSRecommendViewController recommendViewController];
    [self.navigationController pushViewController:recommendVC animated:YES];
}











@end
