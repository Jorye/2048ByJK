//
//  UIColor+HB.h
//  ztemall
//
//  Created by liuhongbao on 15/8/28.
//  Copyright (c) 2015年 heysroad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HB)
/**
 * 将16进制颜色转换成UIColor
 *
 **/
+(UIColor *)getColor:(NSString *)hexColor;
@end
