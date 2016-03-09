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
#define BSLog(fmt, ...) NSLog((@"[Line = %d]:" fmt), __LINE__, ##__VA_ARGS__);
#else
#define BSLog(...)
#endif

#define BSLogFunc BSLog(@"%s",__func__);



/**
 Synthsize a weak or strong reference.
 
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */

#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
        #else
        #define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
        #endif
    #endif
#endif

#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
        #define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
        #endif
    #else
        #if __has_feature(objc_arc)
        #define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
        #else
        #define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
        #endif
    #endif
#endif








#endif