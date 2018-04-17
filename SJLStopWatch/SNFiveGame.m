//
//  SNFiveGame.m
//  Stopwatch
//
//  Created by jinlong sheng on 2018/4/17.
//  Copyright © 2018年 吴冰. All rights reserved.
//

#import "SNFiveGame.h"
#import "SNTimer.h"
#define Screen_W [UIScreen mainScreen].bounds.size.width
#define Screen_H [UIScreen mainScreen].bounds.size.height
@interface SNFiveGame(){
    UIControl *control;
    UIView *mainView;
    UIImageView *backView;
    UILabel *timeLabel;
    
    UILabel *_secondL;
    UILabel *_secondR;
    
    UILabel *_msecL;
    UILabel *_msecM;
    UILabel *_msecR;
    
    
    NSDate * date1970;
    NSDate * startCountDate;
    SNTimer *gcdTimer;
    
    BOOL GCD;
}
@property (nonatomic,strong) NSTimer *timer;
@end
@implementation SNFiveGame
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        GCD=YES;
        control =[[UIControl alloc] initWithFrame:self.bounds];
        control.backgroundColor=[UIColor lightGrayColor];
        control.alpha=0.5;
        [control addTarget:self action:@selector(showSmallAnimation) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:control];
        
        mainView = [[UIView alloc]initWithFrame:CGRectMake(0, Screen_H-315, Screen_W, 315)];
        mainView.backgroundColor=[UIColor whiteColor];
        mainView.userInteractionEnabled=YES;
        [self buildMainView];
        [self addSubview:mainView];
        
    }
    return self;
}
- (void)buildMainView{
    backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 295, 102)];
    backView.center=CGPointMake(Screen_W/2, 100);
    backView.image=[UIImage imageNamed:@"back_view.png"];
    [mainView addSubview:backView];
    
    _secondL = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 52, 78)];
    _secondL.font=[UIFont fontWithName:@"HelveticaNeue" size:75];
    _secondL.text=@"0";
    _secondL.textAlignment=NSTextAlignmentCenter;
//    _secondL.backgroundColor=[UIColor redColor];
    _secondL.textColor=[UIColor whiteColor];
    [backView addSubview:_secondL];
    
    _secondR = [[UILabel alloc]initWithFrame:CGRectMake(57, 0, 52, 78)];
    _secondR.font=[UIFont fontWithName:@"HelveticaNeue" size:75];
    _secondR.text=@"0";
    _secondR.textAlignment=NSTextAlignmentCenter;
//    _secondR.backgroundColor=[UIColor redColor];
    _secondR.textColor=[UIColor whiteColor];
    [backView addSubview:_secondR];
    
    _msecL = [[UILabel alloc]initWithFrame:CGRectMake(129, 0, 52, 78)];
    _msecL.font=[UIFont fontWithName:@"HelveticaNeue" size:75];
    _msecL.text=@"0";
    _msecL.textAlignment=NSTextAlignmentCenter;
//    _msecL.backgroundColor=[UIColor redColor];
    _msecL.textColor=[UIColor whiteColor];
    [backView addSubview:_msecL];
    
    _msecM = [[UILabel alloc]initWithFrame:CGRectMake(130+56, 0, 52, 78)];
    _msecM.font=[UIFont fontWithName:@"HelveticaNeue" size:75];
    _msecM.text=@"0";
    _msecM.textAlignment=NSTextAlignmentCenter;
//    _msecM.backgroundColor=[UIColor redColor];
    _msecM.textColor=[UIColor whiteColor];
    [backView addSubview:_msecM];
    
    _msecR = [[UILabel alloc]initWithFrame:CGRectMake(130+57+56, 0, 52, 78)];
    _msecR.font=[UIFont fontWithName:@"HelveticaNeue" size:75];
    _msecR.text=@"0";
    _msecR.textAlignment=NSTextAlignmentCenter;
//    _msecR.backgroundColor=[UIColor redColor];
    _msecR.textColor=[UIColor whiteColor];
    [backView addSubview:_msecR];
    
    UIButton *start = [[UIButton alloc]initWithFrame:CGRectMake(0, 200, 60, 40)];
    start.backgroundColor=[UIColor greenColor];
    [start setTitle:@"开始" forState:UIControlStateNormal];
    [start addTarget:self action:@selector(startt) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:start];
    
    UIButton *end = [[UIButton alloc]initWithFrame:CGRectMake(200, 200, 60, 40)];
    end.backgroundColor=[UIColor redColor];
     [end setTitle:@"重置" forState:UIControlStateNormal];
    [end addTarget:self action:@selector(resett) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:end];
    
    UIButton *pausebtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 60, 40)];
    pausebtn.backgroundColor=[UIColor redColor];
     [pausebtn setTitle:@"暂停" forState:UIControlStateNormal];
    [pausebtn addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:pausebtn];
}
-(void)updateLabel{
    NSTimeInterval timeDieff = [[[NSDate alloc]init]timeIntervalSinceDate:startCountDate];
    NSDate * timeToShow = [NSDate date];
    
    timeToShow = [date1970 dateByAddingTimeInterval:timeDieff];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"ss SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSString *strDate = [dateFormatter stringFromDate:timeToShow];
    NSLog(@"%@ ===",strDate);
    _secondL.text=[strDate substringWithRange:NSMakeRange(0, 1)];
    _secondR.text=[strDate substringWithRange:NSMakeRange(1, 1)];
    
    _msecL.text=[strDate substringWithRange:NSMakeRange(3, 1)];
    _msecM.text=[strDate substringWithRange:NSMakeRange(4, 1)];
    _msecR.text=[strDate substringWithRange:NSMakeRange(5, 1)];
}

-(void)resett{
    if(GCD){
        [gcdTimer stop];
    }else{
        [_timer setFireDate:[NSDate distantFuture]];
    }
    
    _secondL.text=@"0";
    _secondR.text=@"0";
    _msecL.text=@"0";
    _msecM.text=@"0";
    _msecR.text=@"0";
}
-(void)startt{
//    date1970 = [NSDate dateWithTimeIntervalSince1970:0];
    startCountDate = [NSDate date];
    if(GCD){
        
            if(gcdTimer == nil){
                __weak id weakSelf = self;
                date1970 = [NSDate dateWithTimeIntervalSince1970:0];
                gcdTimer = [SNTimer repeatingTimerWithTimeInterval:0.001 block:^{
                    [weakSelf updateLabel];
                }];
         
                [gcdTimer fire];
            }else{
                [gcdTimer fire];
            }
        
    }else{
    
    
    
            if(_timer == nil){
                date1970 = [NSDate dateWithTimeIntervalSince1970:0];
                _timer = [NSTimer scheduledTimerWithTimeInterval:0.001f target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
                [_timer fire];
            }else{
                [_timer setFireDate:[NSDate distantPast]];
            }
    
    
    }
}
-(void)pause{
    if(GCD){
        [gcdTimer stop];
    }else{
        [_timer setFireDate:[NSDate distantFuture]];
    }
}


- (void)show{
    self.hidden=NO;
    [UIView animateWithDuration:0.3 animations:^{
        mainView.frame =CGRectMake(0, Screen_H-315, Screen_W, 315);
        control.alpha=0.5;
    } completion:^(BOOL finished) {
    }];
    
    
    
}
- (void)showSmallAnimation{
 
        [UIView animateWithDuration:0.3 animations:^{
            control.alpha = 0.f;
            mainView.frame =CGRectMake(0, Screen_H, Screen_W, 315);
        } completion:^(BOOL finished) {
         
            self.hidden=YES;
        }];
    }

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
