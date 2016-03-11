//
//  BSTextField.m
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/9.
//  Copyright © 2016年 CX. All rights reserved.
//

#import "BSTextField.h"
#import <objc/runtime.h>

@implementation BSTextField

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        /*
        unsigned int count;
        Ivar *ivars = class_copyIvarList([UITextField class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            BSLog(@"%s,%s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
        }
        free(ivars);*/
//        _placeholderLabel
        [self setup];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.tintColor = [UIColor whiteColor];
    [self resignFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}

@end
