//
//  Model.h
//  2048ByJK
//
//  Created by zte on 16/10/13.
//  Copyright © 2016年 zte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

/*
 *纬度
 */
@property(nonatomic,assign)int dimension;

/*
 *16个模块
 */
@property(nonatomic,strong)NSMutableArray *bit;

/*
 *分数
 */
@property(nonatomic,assign)int score;

/*
 *初始化
 */
-(instancetype)init;
/*
 *生成随机位置数字
 */
-(void)getNumber;

/*
 *获取数字为0位置
 */
-(NSArray *)getNull;

/*
 *清除面板
 */
-(void)setZero;

/*
 *所以模块移动
 */
-(void)left;
-(void)right;
-(void)up;
-(void)down;

/*
 *所以模块移动合并
 */
-(void)leftMerge;
-(void)rightMerge;
-(void)upMerge;
-(void)downMerge;

/*
 * 打印实时的模块
 */
-(void)printModel;

@end
