//
//  NSDate+BSExtension.h
//  BaiSiBuDeJie
//
//  Created by c_xie on 16/3/12.
//  Copyright © 2016年 CX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BSExtension)

- (BOOL)isThisYear;
- (BOOL)isToday;
- (BOOL)isYesterday;
- (NSDateComponents *)deltaFrom:(NSDate *)startdate;

@end
