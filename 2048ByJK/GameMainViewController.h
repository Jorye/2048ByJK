//
//  GameMainViewController.h
//  2048ByJK
//
//  Created by zte on 16/10/12.
//  Copyright © 2016年 zte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "View.h"
typedef NS_OPTIONS(NSUInteger, TipEvents) {
    TipEventsLongPress                             = 0,
    TipEventsSJ                                    = 1,
    TipEventsAdd                                   = 2,
    TipEventsNull                                  = 3
};




@interface GameMainViewController : UIViewController
@property(nonatomic,strong)Model *model;

@property(nonatomic,strong)UIView *mainView;

@property(nonatomic,strong)UIView *saveMain;

@property(nonatomic,strong)UILabel *scoreContent;

@property(nonatomic,strong)UIView *tipView;

@property(nonatomic,strong)UILabel *tipContent;

@property(nonatomic,strong)UILabel *bestContent;

@property(nonatomic,strong)UILabel *totalScore;

@property(nonatomic,strong)NSString *total;

@property(nonatomic,strong)UIButton *sj;

@property(nonatomic,strong)UIButton *lPress;

@property(nonatomic,strong)UIButton *sjDisappear;

@property(nonatomic,strong)UIButton *addM;

@property(nonatomic,strong)UIView *indexView;

@property(nonatomic,strong)UIButton *cancelBtn;

@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,assign)TipEvents events;

/*
 *1时为随机中产生的save，0时为自己选择的save
 */
@property(nonatomic,assign)NSInteger flag;
/*
 *记数
 */
@property(nonatomic,strong)NSMutableArray *memory;
@end
