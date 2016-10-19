//
//  UIColor+HB.m
//  ztemall
//
//  Created by liuhongbao on 15/8/28.
//  Copyright (c) 2015年 heysroad. All rights reserved.
//

#import "UIColor+HB.h"

@implementation UIColor (HB)
/**
 * 将16进制颜色转换成UIColor
 *
 **/
+(UIColor *)getColor:(NSString *)hexColor {
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}
@end
