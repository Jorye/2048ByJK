//
//  View.h
//  2048ByJK
//
//  Created by zte on 16/10/14.
//  Copyright © 2016年 zte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
@interface View : UIView

@property(nonatomic,strong)NSMutableDictionary *colorDic;

@property(nonatomic,strong)Model *model;

-(UIView *)setViewWithValue:(int)value;

@end
