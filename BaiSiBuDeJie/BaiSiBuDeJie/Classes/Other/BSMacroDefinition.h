//
//  BSMacroDefinition.h
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/8.
//  Copyright © 2016年 CX. All rights reserved.
//

#ifndef BS_Macro_Definition
#define BS_Macro_Definition

#define BS_SCREEN_BOUNDS [UIScreen mainScreen].bounds

#define BS_RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define BS_RandomRGBColor BS_RGBAColor(arc4random_uniform(255.0),arc4random_uniform(255.0),arc4random_uniform(255.0),1.0)


#ifdef DEBUG
#define BSLog(fmt, ...) NSLog((@"[func = %s Line = %d]:" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define BSLog(...)
#endif

#define BSLogFunc BSLog(@"%s",__func__);


#endif