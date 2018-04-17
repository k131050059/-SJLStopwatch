//
//  ViewController.m
//  SJLStopWatch
//
//  Created by jinlong sheng on 2018/4/17.
//  Copyright © 2018年 sjl. All rights reserved.
//

#import "ViewController.h"
#import "SNFiveGame.h"
@interface ViewController (){
    SNFiveGame *fview;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *start = [[UIButton alloc]initWithFrame:CGRectMake(0, 200, 60, 40)];
    start.backgroundColor=[UIColor greenColor];
    [start setTitle:@"show" forState:UIControlStateNormal];
    [start addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:start];
    
    fview = [[SNFiveGame alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    fview.userInteractionEnabled=YES;
    [fview showSmallAnimation];
    [self.view addSubview:fview];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)show{
     [fview show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
