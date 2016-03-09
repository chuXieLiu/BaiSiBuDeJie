//
//  BSLoginViewController.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/9.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSLoginViewController.h"

@interface BSLoginViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginLeftCons;
@property (weak, nonatomic) IBOutlet UIButton *regitsterButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation BSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.regitsterButton.layer.cornerRadius = 5.0f;
    self.regitsterButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 5.0f;
    self.loginButton.layer.masksToBounds = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)dismiss:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)reigister:(UIButton *)sender {
    [self.view endEditing:YES];
    if (self.loginLeftCons.constant == 0) {
        self.loginLeftCons.constant = -self.view.width;
        [sender setTitle:@"已有账号" forState:UIControlStateNormal];
    } else {
        self.loginLeftCons.constant = 0;
        [sender setTitle:@"注册账号" forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

@end
