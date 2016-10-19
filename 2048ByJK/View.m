//
//  View.m
//  2048ByJK
//
//  Created by zte on 16/10/14.
//  Copyright © 2016年 zte. All rights reserved.
//
#define WIDTH [UIScreen mainScreen].bounds.size.width
#import "View.h"
#import "UIColor+HB.h"
@implementation View
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    self = [super init];
    if (self) {
        
        _model = [[Model alloc]init];
        
        _colorDic = [[NSMutableDictionary alloc]initWithDictionary:@{
        @"0":[UIColor getColor:@"FFFFFF"],
        @"2":[UIColor getColor:@"FFF68F"],
        @"4":[UIColor getColor:@"FFD700"],
        @"8":[UIColor getColor:@"FFB90F"],
        @"16":[UIColor getColor:@"FF8C69"],
        @"32":[UIColor getColor:@"FF4040"],
        @"64":[UIColor getColor:@"FF0000"],
        @"128":[UIColor getColor:@"63B8FF"],
        @"256":[UIColor getColor:@"00B2EE"],
        @"512":[UIColor getColor:@"009ACD"],
        @"1024":[UIColor getColor:@"00688B"],
        @"2048":[UIColor getColor:@"0000CD"],
        @"4096":[UIColor getColor:@"000080"],
        @"8192":[UIColor getColor:@"000000"]
        }];
        
        
        
    }
    return self;
}

-(UIView *)setViewWithValue:(int)value{
    UIView *view = [[UIView alloc]init];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH*20/100, WIDTH*20/100)];
    label.text = [NSString stringWithFormat:@"%d",value];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = _colorDic[label.text];
//    label.backgroundColor = [UIColor blueColor];
    [view addSubview:label];
    return view;
}



@end
