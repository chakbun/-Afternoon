//
//  UIColor+JRColor.m
//  Afternoon
//
//  Created by Jaben on 16/2/29.
//  Copyright © 2016年 After. All rights reserved.
//

#import "UIColor+JRColor.h"

@implementation UIColor (JRColor)

+ (UIColor *)color4SimpleWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return  [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

+ (UIColor *)themeGreyGreen {
    return [UIColor color4SimpleWithRed:131 green:174 blue:171 alpha:0.5];
}

@end
