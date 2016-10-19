//
//  Model.m
//  2048ByJK
//
//  Created by zte on 16/10/13.
//  Copyright © 2016年 zte. All rights reserved.
//

#import "Model.h"

@implementation Model



-(instancetype)init{
    self = [super init];
    if (self) {
        
        self.dimension = 4;
        self.bit = [[NSMutableArray alloc]init];
        for (int i = 0; i < self.dimension; i++) {
            for (int j = 0; j <self.dimension; j++) {
                [self.bit addObject:@"0"];
            }
        }
    }
    return self;
}


-(void)getNumber{
    NSArray *arrNull = [self getNull];
    if ([arrNull count] > 0) {
        //获取位置
        int index = arc4random()%[arrNull count];
        //获取大小数字
        int number = arc4random()%1000<900?2:4;
        _bit[[arrNull[index] intValue]] = [NSString stringWithFormat:@"%d",number];
    }else{
        NSLog(@"没位置了");
    }
}

-(NSArray *)getNull{
    NSMutableArray *arrNull = [NSMutableArray array];
    for (int i = 0; i <_dimension*_dimension; i++) {
        if ([_bit[i] intValue] == 0) {
            [arrNull addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return arrNull;
}

-(void)setZero{
    self.bit = [[NSMutableArray alloc]init];
    for (int i = 0; i < self.dimension; i++) {
        for (int j = 0; j <self.dimension; j++) {
            [self.bit addObject:@"0"];
        }
    }
}


-(void)right{
    for (int i = 0; i < _dimension; i++) {
        for (int j = 0; j < _dimension -1; j++) {
            int index = i * _dimension + j;
            int now = index;
            if ([_bit[now] intValue] != 0 && [_bit[now+1] intValue] == 0) {
                [self exchangeModelOfNumberA:now+1 WithB:now];
                
                while ( now-1 >= i*_dimension &&[_bit[now - 1] intValue] != 0) {
                    [self exchangeModelOfNumberA:now-1 WithB:now];
                    now--;
                }
            }
        }
    }
}

-(void)rightMerge{
    for (int i = 0; i<_dimension; i++) {
        for (int j = _dimension -1; j>0; j--) {
            int index = i*_dimension +j;
            if (_bit[index] == _bit[index -1] && index >i*_dimension) {
                [self mergeOnModelOfNumberA:index WithB:index-1];
            }
        }
    }
}

-(void)left{
    for (int i = 0; i < _dimension; i++) {
        for (int j = _dimension -1; j >0; j--) {
            int index = i * _dimension + j;
            int now = index;
            if ([_bit[now] intValue] != 0 && [_bit[now-1] intValue] == 0) {
                [self exchangeModelOfNumberA:now-1 WithB:now];
                
                while ( now+1 < (i+1)*_dimension &&[_bit[now + 1] intValue] != 0) {
                    [self exchangeModelOfNumberA:now+1 WithB:now];
                    now++;
                }
            }
        }
    }
}

-(void)leftMerge{
    for (int i = 0; i<_dimension; i++) {
        for (int j = 0; j<_dimension -1; j++) {
            int index = i*_dimension +j;
            if (_bit[index] == _bit[index +1] && index <(i+1)*_dimension) {
                [self mergeOnModelOfNumberA:index WithB:index+1];
            }
        }
    }
}

-(void)down{
    for (int i = 0; i < _dimension; i++) {
        for (int j = 0; j < _dimension-1; j++) {
            int index = j * _dimension + i;
            int now = index;
            if ([_bit[now] intValue] != 0 && [_bit[now+_dimension] intValue] == 0) {
                [self exchangeModelOfNumberA:now+_dimension WithB:now];
                
                while ( now-_dimension >= i &&[_bit[now - _dimension] intValue] != 0) {
                    [self exchangeModelOfNumberA:now-_dimension WithB:now];
                    now-=_dimension;
                }
            }
        }
    }
}

-(void)downMerge{
    for (int i = 0; i<_dimension; i++) {
        for (int j = _dimension -1; j>0; j--) {
            int index = j*_dimension +i;
            if (_bit[index] == _bit[index -_dimension] && index >i) {
                [self mergeOnModelOfNumberA:index WithB:index-_dimension];
            }
        }
    }
}

-(void)up{
    for (int i = 0; i < _dimension; i++) {
        for (int j = _dimension -1; j >0; j--) {
            int index = j * _dimension + i;
            int now = index;
            if ([_bit[now] intValue] != 0 && [_bit[now-_dimension] intValue] == 0) {
                [self exchangeModelOfNumberA:now-_dimension WithB:now];
                
                while ( now+_dimension < i+_dimension*_dimension &&[_bit[now + _dimension] intValue] != 0) {
                    [self exchangeModelOfNumberA:now+_dimension WithB:now];
                    now+=_dimension;
                }
            }
        }
    }
}

-(void)upMerge{
    
    for (int i = 0; i<_dimension; i++) {
        for (int j = 0; j<_dimension -1; j++) {
            int index = j*_dimension +i;
            if (_bit[index] == _bit[index +_dimension] ) {
                [self mergeOnModelOfNumberA:index WithB:index+_dimension];
            }
        }
    }
    
}



/*
 *合并数字
 *A为合并数字B为被合并数字
*/
 -(void)mergeOnModelOfNumberA:(int)A WithB:(int)B{
     _bit[A] = [NSString stringWithFormat:@"%d",[_bit[A] intValue]*2];
     _bit[B] = @"0";
     _score += [_bit[A] integerValue];
}

//交换数字
-(void)exchangeModelOfNumberA:(int)A WithB:(int)B{
    NSString *temp = _bit[A];
    _bit[A] = _bit[B];
    _bit[B] = temp;
}




-(void)printModel{
    NSString *str = [[NSString alloc]init];
    for (int i = 0; i < self.dimension; i++) {
        for (int j = 0; j < self.dimension; j++) {
            
            int index = i * self.dimension + j;
            
            str = [str stringByAppendingFormat:@"%d ",[_bit[index] intValue]];
        }
        str = [str stringByAppendingString:@"\n"];
    }
    NSLog(@"%@\n%d",str,_score);
}



@end
