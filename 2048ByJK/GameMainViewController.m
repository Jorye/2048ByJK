//
//  GameMainViewController.m
//  2048ByJK
//
//  Created by zte on 16/10/12.
//  Copyright © 2016年 zte. All rights reserved.
//

#import "GameMainViewController.h"
#import "UIColor+HB.h"


#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface GameMainViewController ()

@end

@implementation GameMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    _total = [NSString string];
    self.view.backgroundColor = [UIColor grayColor];
    [self.navigationController setNavigationBarHidden:YES];
    _model = [[Model alloc]init];
    [self setUI];
    [self startGame];
    _flag = 0;
    
}
#pragma mark 界面布局
-(void)setUI{
    
    //SCORE 记分板
    
    UIView *scoreView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH*5/100, HEIGHT*10/100, WIDTH*20/100, HEIGHT*10/100)];
    scoreView.backgroundColor = [UIColor getColor:@"666666"];
    UILabel *scoreTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH*20/100, HEIGHT*5/100)];
    scoreTitle.text = @"SCORE";
    scoreTitle.textAlignment = NSTextAlignmentCenter;
    _scoreContent = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT*5/100, WIDTH*20/100, HEIGHT*5/100)];
    _scoreContent.text = @"0";
    _scoreContent.textAlignment = NSTextAlignmentCenter;
    [scoreView addSubview:scoreTitle];
    [scoreView addSubview:_scoreContent];
    [self.view addSubview:scoreView];
    //BEST 最高分
    
    UIView *bestView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH*75/100, HEIGHT*10/100, WIDTH*20/100, HEIGHT*10/100)];
    bestView.backgroundColor = [UIColor getColor:@"666666"];
    
    UILabel *bestTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH*20/100, HEIGHT*5/100)];
    bestTitle.text = @"BEST";
    bestTitle.textAlignment = NSTextAlignmentCenter;
    _bestContent = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT*5/100, WIDTH*20/100, HEIGHT*5/100)];
    _bestContent.text = @"0";
    _bestContent.textAlignment = NSTextAlignmentCenter;
    [bestView addSubview:bestTitle];
    [bestView addSubview:_bestContent];
    
    [self.view addSubview:bestView];
    
    //TIP 提示
    _tipView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH*27/100, HEIGHT*5/100, WIDTH*46/100, HEIGHT*20/100)];
    _tipView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    
    _tipContent = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH*46/100, HEIGHT*20/100)];
    _tipContent.textAlignment = NSTextAlignmentCenter;
    _tipContent.numberOfLines = 0;
    _tipContent.text = @"Happy Game";
    [_tipView addSubview:_tipContent];
    [self.view addSubview:_tipView];
    
    //TOTAL SCORE
    _totalScore = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH*27/100, HEIGHT*26/100, WIDTH*46/100, 20)];
    _totalScore.backgroundColor = [UIColor whiteColor];
    _totalScore.text = @"TOTAL：0t";
    _totalScore.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_totalScore];
    
    
    //MAIN 游戏主板
    
    _mainView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH*2.5/100, HEIGHT*30/100, WIDTH*95/100, WIDTH*95/100)];
    _mainView.backgroundColor = [UIColor getColor:@"999999"];
    
    //给主板添加手势
    UISwipeGestureRecognizer *upSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(upSwipe)];
    upSwipe.direction = UISwipeGestureRecognizerDirectionUp;
    upSwipe.numberOfTouchesRequired = 1;
    [_mainView addGestureRecognizer:upSwipe];
    
    UISwipeGestureRecognizer *downSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(downSwipe)];
    downSwipe.direction = UISwipeGestureRecognizerDirectionDown;
    downSwipe.numberOfTouchesRequired = 1;
    [_mainView addGestureRecognizer:downSwipe];
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    leftSwipe.numberOfTouchesRequired = 1;
    [_mainView addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    rightSwipe.numberOfTouchesRequired = 1;
    [_mainView addGestureRecognizer:rightSwipe];
    
    [self.view addSubview:_mainView];
    
    
    
    //BACK 退一步

    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH*5/100, HEIGHT*85/100, WIDTH*20/100, HEIGHT*10/100)];
    backBtn.backgroundColor = [UIColor getColor:@"666999"];
    [backBtn setTitle:@"BACK" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    //RESET 重置
    
    UIButton *resetBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH*40/100, HEIGHT*85/100, WIDTH*20/100, HEIGHT*10/100)];
    resetBtn.backgroundColor = [UIColor getColor:@"666999"];
    [resetBtn setTitle:@"RESET" forState:UIControlStateNormal];
    [resetBtn addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetBtn];
    //SAVE 解救
    
    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH*75/100, HEIGHT*85/100, WIDTH*20/100, HEIGHT*10/100)];
    saveBtn.backgroundColor = [UIColor getColor:@"666999"];
    [saveBtn setTitle:@"SAVE" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    
    [self setBest];
}



#pragma mark 扫动处理
-(void)upSwipe{
    [_model up];
    [_model upMerge];
    [_model up];
    [_model printModel];
    [self dealStep];
}

-(void)downSwipe{
    [_model down];
    [_model downMerge];
    [_model down];
    [self dealStep];
}

-(void)leftSwipe{
    [_model left];
    [_model leftMerge];
    [_model left];
    [self dealStep];
}

-(void)rightSwipe{
    [_model right];
    [_model rightMerge];
    [_model right];
    [self dealStep];
}
#pragma mark 处理步骤
-(void)dealStep{
    //测试是否为死局
    if ([_model getNull].count == 0) {
        BOOL flagIsDead;
        flagIsDead = YES;
        //上
        [_model up];
        [_model upMerge];
        [_model up];
        if ([_model getNull].count >0) {
            flagIsDead = NO;
        }
        _model.score = [_memory[_memory.count -1][0] intValue];
        _model.bit = [[NSMutableArray alloc]initWithArray:_memory[_memory.count -1][1]];
        //下
        [_model down];
        [_model downMerge];
        [_model down];
        if ([_model getNull].count >0) {
            flagIsDead = NO;
        }
        _model.score = [_memory[_memory.count -1][0] intValue];
        _model.bit = [[NSMutableArray alloc]initWithArray:_memory[_memory.count -1][1]];
        //左
        [_model left];
        [_model leftMerge];
        [_model left];
        if ([_model getNull].count >0) {
            flagIsDead = NO;
        }
        _model.score = [_memory[_memory.count -1][0] intValue];
        _model.bit = [[NSMutableArray alloc]initWithArray:_memory[_memory.count -1][1]];
        //右
        [_model right];
        [_model rightMerge];
        [_model right];
        if ([_model getNull].count >0) {
            flagIsDead = NO;
        }
        _model.score = [_memory[_memory.count -1][0] intValue];
        _model.bit = [[NSMutableArray alloc]initWithArray:_memory[_memory.count -1][1]];
        if (flagIsDead) {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"WARM!" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *backAction = [UIAlertAction actionWithTitle:@"BACK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self back];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"CANCEL" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self reset];
            }];
            [alertC addAction:backAction];
            [alertC addAction:cancelAction];
            [self presentViewController:alertC animated:YES completion:^{
                
            }];
        }
    }
    
    if ([_memory.lastObject[1] isEqualToArray:_model.bit]) {
        return;
    }else{
        [_model getNumber];
        [self draw];
        [self memoryStep];
    }
}

#pragma mark 画出当前模块
-(void)draw{
    
    for (int i = 0; i < _model.dimension; i++) {
        for (int j = 0; j < _model.dimension; j++) {
            int index = i*_model.dimension+j;
            View *drawView = [[View alloc]init];
            UIView *modelView = [[UIView alloc]init];
            modelView.frame = CGRectMake(WIDTH*1.5/100+WIDTH*20/100*j+WIDTH*4/100*j,
                                    WIDTH*1.5/100+WIDTH*20/100*i+WIDTH*4/100*i,
                                    WIDTH*20/100,
                                         WIDTH*20/100);
            modelView.backgroundColor = [UIColor grayColor];
            [modelView addSubview:[drawView setViewWithValue:[_model.bit[index] intValue]]];
            modelView.tag = 100 +index;
            UITapGestureRecognizer *pushDown = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dealTipEvents:)];
            pushDown.numberOfTouchesRequired = 1;
            
            [modelView addGestureRecognizer:pushDown];
            
            
            
            [_mainView addSubview:modelView];
        }
    }
    _scoreContent.text = [NSString stringWithFormat:@"%d",_model.score];
    [_model printModel];
    [self keepBest];
    
}

-(void)dealTipEvents:(UITapGestureRecognizer *)gesture{
    UIView *view = gesture.view;
    
    if (_events == TipEventsLongPress) {
        [self dealFirst:view.tag];
    }
    
    if (_events == TipEventsSJ) {
        [self dealSecond:view.tag];
    }
    
    if (_events == TipEventsAdd) {
        [self dealThird:view.tag];
    }
    
    
    
}

#pragma mark 开启处理
-(void)startGame{
    NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/Data.plist",NSHomeDirectory()];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *best = [[NSDictionary alloc]initWithContentsOfFile:path];
    int score = [best[@"score"] intValue];
    if ([fm fileExistsAtPath:path] && score != 0) {
        [self draw];
    }else{
        [self reset];
    }
    
}

#pragma mark 与沙盒相关
-(void)setBest{
    NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/Data.plist",NSHomeDirectory()];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        NSDictionary *best = [[NSDictionary alloc]initWithContentsOfFile:path];
        _scoreContent.text = best[@"score"];
        _bestContent.text = best[@"best"];
        _model.bit = best[@"model"];
        _model.score = [best[@"score"] intValue];
        _memory = best[@"memory"];
        _total = best[@"total"];
        _totalScore.text = [NSString stringWithFormat:@"TOTAL：%@t",_total];
    }else{
        _bestContent.text = @"0";
        NSDictionary *dic = @{@"best":@"0",@"score":@"0",@"model":@[],@"memory":@[],@"total":@"0"};
        if ([dic writeToFile:path atomically:YES]) {
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"WARM!" message:@"SUCCESS INIT\n GO TO START" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertC addAction:cancelAction];
            [self presentViewController:alertC animated:YES completion:^{
                
            }];
        }else{
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"WARM!" message:@"DEFAULT INIT\n Please REMOUNT" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertC addAction:cancelAction];
            [self presentViewController:alertC animated:YES completion:^{
                
            }];
        }
    }
}

-(void)keepBest{
    NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/Data.plist",NSHomeDirectory()];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
        
        [dic setObject:_scoreContent.text forKey:@"score"];
        [dic setObject:_model.bit forKey:@"model"];
        [dic setObject:_memory forKey:@"memory"];
        if ([_scoreContent.text intValue] > [dic[@"best"] intValue]) {
            _bestContent.text = _scoreContent.text;
            [dic setObject:_bestContent.text forKey:@"best"];
            NSLog(@"best == %@",[dic objectForKey:@"best"]);
        }
        [dic writeToFile:path atomically:YES];
    }
}

-(void)keepTotal{
    NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/Data.plist",NSHomeDirectory()];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
        int totalN = [_total intValue];
        int score = [dic[@"score"] intValue];
        _total = [NSString stringWithFormat:@"%d",totalN + score];
        dic[@"total"] = _total;
        _totalScore.text = [NSString stringWithFormat:@"TOTAL：%@t",_total];
        [dic writeToFile:path atomically:YES];
    }
}

#pragma mark 扣除分数
-(void)reduceScore:(NSString *)style{
    NSString *path = [NSString stringWithFormat:@"%@/Library/Caches/Data.plist",NSHomeDirectory()];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
        int totalN = [_total intValue];
        int reduce = 0;
        if ([style isEqualToString:@"sj"]) {
            reduce = 600;
        }
        if ([style isEqualToString:@"longPress"]) {
            reduce = 1000;
        }
        if ([style isEqualToString:@"suprised"]) {
            reduce = 900;
        }
        if ([style isEqualToString:@"Add"]) {
            reduce = 500;
        }
        _total = [NSString stringWithFormat:@"%d",totalN - reduce];
        dic[@"total"] = _total;
        _totalScore.text = [NSString stringWithFormat:@"TOTAL：%@t",_total];
        [dic writeToFile:path atomically:YES];
    }
}


#pragma mark 返回步骤处理
-(void)back{
    if (_memory.count == 1) {
        return;
    }
    [_memory removeLastObject];
    _model.score = [_memory[_memory.count -1][0] intValue];
    _model.bit = [[NSMutableArray alloc]initWithArray:_memory[_memory.count -1][1]];
    NSLog(@"%@",_memory[_memory.count -1][1]);
    
    [self draw];
}

-(void)memoryStep{
    NSMutableArray *bit = [[NSMutableArray alloc]initWithArray:_model.bit];
    NSArray *step = @[_scoreContent.text,bit];
    [_memory addObject:step];
}


#pragma mark 重新布局
-(void)reset{
    [self keepTotal];
    _memory = [NSMutableArray array];
    [_model setZero];
    for (int i = 0; i<4; i++) {
        [_model getNumber];
    }
    _model.score = 0;
    _events = TipEventsNull;
    _tipContent.text = @"Happy Game";
    [self draw];
    [self memoryStep];
    _flag = 0;
}

#pragma mark 提示小技巧
-(void)drawTipWithType{
    switch (_events) {
        case 0:
        {
            _tipContent.text = @"TIP:1 Delete module for the specified location";
        }
            break;
        case 1:
        {
            _tipContent.text = @"TIP:2 Specify the location of squares random surprise";
        }
            break;
        case 2:
        {
            _tipContent.text = @"TIP:3 Add the module for the specified location";
        }
            break;
            
        default:
            break;
    }
}



#pragma mark 解救死局
-(void)save{
    if (_saveMain) {
        if (_saveMain.isHidden) {
            _saveMain.hidden = NO;
        }else{
            _saveMain.hidden = YES;
        }
    }else{
        [self saveMainUI];
    }
}
//解救主板UI
-(void)saveMainUI{
    _saveMain =[[UIView alloc]initWithFrame:CGRectMake(WIDTH*10/100, HEIGHT*20/100, WIDTH*80/100, HEIGHT*65/100)];
    _saveMain.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _saveMain.tag = 200;
    //思路一、1.模块消失1000积分，2.范围内随机消失800积分，3.添加model500积分，4.随机获得前三种的一个700积分 随机采用翻箱子模式 二、执行前再次询问

    //网说是翻牌效果
//    [UIView beginAnimations:@"View Filp" context:nil];
//    [UIView setAnimationDelay:0.25];
//    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:_saveMain cache:NO];
//    [UIView commitAnimations];
    
    //随机
    _sj = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH*20/100, WIDTH*10/100, WIDTH*40/100, WIDTH*40/100)];
    _sj.backgroundColor = [UIColor getColor:@"CCCCCC"];
    _sj.layer.cornerRadius = WIDTH*20/100;
    [_sj setTitle:@"RANDOM\n600t" forState:UIControlStateNormal];
    [_sj addTarget:self action:@selector(random) forControlEvents:UIControlEventTouchDown];
    
    //长按消失
    _lPress = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH*15/100, HEIGHT*30/100, WIDTH*50/100, HEIGHT*5/100)];
    _lPress.backgroundColor = [UIColor getColor:@"CCCCCC"];
    _lPress.layer.cornerRadius = 6;
    _lPress.tag = 201;
    [_lPress setTitle:@"Delete 1000t" forState:UIControlStateNormal];
    [_lPress addTarget:self action:@selector(first) forControlEvents:UIControlEventTouchDown];
    
    //随机消失
    _sjDisappear = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH*15/100, HEIGHT*40/100, WIDTH*50/100, HEIGHT*5/100)];
    _sjDisappear.backgroundColor = [UIColor getColor:@"CCCCCC"];
    _sjDisappear.layer.cornerRadius = 6;
    _sjDisappear.tag = 202;
    [_sjDisappear setTitle:@"Surprised 900t" forState:UIControlStateNormal];
    [_sjDisappear addTarget:self action:@selector(second) forControlEvents:UIControlEventTouchDown];
    
    //添加
    _addM = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH*15/100, HEIGHT*50/100, WIDTH*50/100, HEIGHT*5/100)];
    _addM.backgroundColor = [UIColor getColor:@"CCCCCC"];
    _addM.layer.cornerRadius = 6;
    _addM.tag = 203;
    [_addM setTitle:@"Add 500t" forState:UIControlStateNormal];
    [_addM addTarget:self action:@selector(third) forControlEvents:UIControlEventTouchUpInside];
    
    //指标
    _indexView = [[UIView alloc]init];
    _indexView.backgroundColor = [UIColor yellowColor];
    _indexView.layer.cornerRadius = HEIGHT*2.5/100;
    _indexView.hidden = YES;
    
    //取消
    _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH*20/100, HEIGHT*57.5/100, WIDTH*40/100, HEIGHT*5/100)];
    _cancelBtn.backgroundColor = [UIColor redColor];
    _cancelBtn.layer.cornerRadius = HEIGHT*2.5/100;
    _cancelBtn.hidden = YES;
    [_cancelBtn setTitle:@"CANCEL" forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancelSaveUI) forControlEvents:UIControlEventTouchDown];
    
    [_saveMain addSubview:_sj];
    [_saveMain addSubview:_lPress];
    [_saveMain addSubview:_sjDisappear];
    [_saveMain addSubview:_addM];
    [_saveMain addSubview:_indexView];
    [_saveMain addSubview:_cancelBtn];
    [self.view addSubview:_saveMain];
}

-(void)random{
    
    if (_indexView.isHidden) {
         [self reduceScore:@"sj"];
        _flag = 1;
        [_sj setTitle:@"STOP" forState:UIControlStateNormal];
        _sj.backgroundColor = [UIColor redColor];
        _indexView.hidden = NO;
        [_timer invalidate];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(timerAdvanced:) userInfo:nil repeats:YES];
        _cancelBtn.hidden = YES;
    }else{
        
        if (_cancelBtn.isHidden&&!_indexView.hidden) {
            [_timer invalidate];
            [_sj setTitle:@"USE" forState:UIControlStateNormal];
            _sj.backgroundColor = [UIColor getColor:@"B4EEB4"];
            _cancelBtn.hidden = NO;
        }else{
            [_timer invalidate];
            
            if (_indexView.frame.origin.y == HEIGHT*30/100) {
                [self first];
            }else if (_indexView.frame.origin.y == HEIGHT*40/100){
                [self second];
            }else{
                [self third];
            }
            
            for (UIView *subviews in [self.view subviews]) {
                if (subviews.tag==200) {
                    [subviews removeFromSuperview];
                }
            }
            [self saveMainUI];
            _saveMain.hidden = YES;
        }
    }
}

-(void)cancelSaveUI{
    for (UIView *subviews in [self.view subviews]) {
        if (subviews.tag==200) {
            [subviews removeFromSuperview];
        }
    }
    [self saveMainUI];
}

- (void)timerAdvanced:(NSTimer *)timer{
    static int a = 0;
    a++;
    if (a>3) {
        a=1;
    }
    _lPress.backgroundColor = [UIColor getColor:@"CCCCCC"];
    _sjDisappear.backgroundColor = [UIColor getColor:@"CCCCCC"];
    _addM.backgroundColor = [UIColor getColor:@"CCCCCC"];
    switch (a) {
        case 1:
        {
            _indexView.frame = CGRectMake(WIDTH*2.5/100, HEIGHT*30/100, HEIGHT*5/100, HEIGHT*5/100);
            _lPress.backgroundColor = [UIColor yellowColor];
        }
            break;
        case 2:
        {
            _indexView.frame = CGRectMake(WIDTH*2.5/100, HEIGHT*40/100, HEIGHT*5/100, HEIGHT*5/100);
            _sjDisappear.backgroundColor = [UIColor yellowColor];
        }
            break;
        case 3:
        {
            _indexView.frame = CGRectMake(WIDTH*2.5/100, HEIGHT*50/100, HEIGHT*5/100, HEIGHT*5/100);
            _addM.backgroundColor = [UIColor yellowColor];
        }
            break;
            
        default:
            break;
    }
}

-(void)first{
    NSLog(@"1");
    _events = TipEventsLongPress;
    [self drawTipWithType];
    _saveMain.hidden = YES;
    if (_flag == 1) {
        _flag = 0;
        return;
    }
    [self reduceScore:@"longPress"];
}

-(void)dealFirst:(NSInteger)tag{
    
    if ([_model.bit[tag-100] intValue] == 0) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"WARM!" message:@"Please Select a value of the model." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertC addAction:cancelAction];
        [self presentViewController:alertC animated:YES completion:^{
            
        }];

    }else{
        _model.bit[tag-100] = @"0";
        [self draw];
        _events = TipEventsNull;
        _tipContent.text = @"Happy Game";
    }
    
    
}

-(void)second{
    NSLog(@"2");
    _events = TipEventsSJ;
    [self drawTipWithType];
    _saveMain.hidden = YES;
    
    if (_flag == 1) {
        _flag = 0;
        return;
    }
    [self reduceScore:@"suprised"];
}

-(void)dealSecond:(NSInteger)tag{
    tag-=100;
    NSMutableArray *arrTag = [NSMutableArray arrayWithArray:@[[NSString stringWithFormat:@"%ld",tag-5],[NSString stringWithFormat:@"%ld",tag-4],[NSString stringWithFormat:@"%ld",tag-3],
                                                              [NSString stringWithFormat:@"%ld",tag-1],[NSString stringWithFormat:@"%ld",tag],[NSString stringWithFormat:@"%ld",tag+1],
                                                              [NSString stringWithFormat:@"%ld",tag+3],[NSString stringWithFormat:@"%ld",tag+4],[NSString stringWithFormat:@"%ld",tag+5]]];
    
    NSLog(@"%@",arrTag);
    
    
    if (tag%4 == 0) {
        [arrTag removeObjectsInArray:@[[NSString stringWithFormat:@"%ld",tag-5], [NSString stringWithFormat:@"%ld",tag-1],[NSString stringWithFormat:@"%ld",tag+3]]];
    }
    
    if (tag%4 == 3) {
        [arrTag removeObjectsInArray:@[[NSString stringWithFormat:@"%ld",tag-3], [NSString stringWithFormat:@"%ld",tag+1],[NSString stringWithFormat:@"%ld",tag+5]]];
    }
    NSMutableArray *arrTemp = [NSMutableArray arrayWithArray:arrTag];
    for (NSString *str in arrTemp) {
        int n = [str intValue];
        if (n<0 || n>15) {
            [arrTag removeObject:str];
        }
    }
    
    for (int i = 0; i < arrTag.count; i++) {
         _model.bit[[arrTag[i] intValue]] = [NSString stringWithFormat:@"%d",arc4random()%1000<700?0:arc4random()%1000<900?2:4];
    }
    [self  draw];
    _events = TipEventsNull;
    _tipContent.text = @"Happy Game";
    
}

-(void)third{
    NSLog(@"3");
    _events = TipEventsAdd;
    [self drawTipWithType];
    _saveMain.hidden = YES;
    if (_flag == 1) {
        _flag = 0;
        return;
    }
    [self reduceScore:@"Add"];
}

-(void)dealThird:(NSInteger)tag{
    if ([_model.bit[tag-100] intValue] != 0) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"WARM!" message:@"Please Select a not value of the model." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertC addAction:cancelAction];
        [self presentViewController:alertC animated:YES completion:^{
            
        }];
        
    }else{
        _model.bit[tag-100] = [NSString stringWithFormat:@"%d",arc4random()%1000<900?2:4];
        [self draw];
        _events = TipEventsNull;
        _tipContent.text = @"Happy Game";
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
