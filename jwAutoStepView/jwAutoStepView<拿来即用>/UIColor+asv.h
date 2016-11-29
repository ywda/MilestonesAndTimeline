//
//  UIColor+asv.h
//  jwAutoStepView
//
//  Created by JW_N on 16/11/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBA_COLOR_ASV(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR_ASV(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]

#define K_SET_COLOR_VALUE(a)   [UIColor colorWithHexString:(a)]
#define K_COLOR_ASV(a,b,c,d) [UIColor colorWithRed:(a)/255.0 green:(b)/255.0 blue:(c)/255.0 alpha:(d)]
#define K_H_COLOR_ASV(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface UIColor (asv)


//从十六进制字符串获取颜色
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式

+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end


/*
 *********************************************************************
 *
 *
 * 博客地址:http://www.jianshu.com/p/80ef2d47729d
 * GitHub:https://github.com/NIUXINGJIAN/MilestonesAndTimeline.git
 * ** 请摁一下，😋 **
 *  做简单的封装，麻烦自己，方便别人
 *********************************************************************
 */
