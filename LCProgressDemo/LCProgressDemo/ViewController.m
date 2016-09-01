//
//  ViewController.m
//  LCProgressDemo
//
//  Created by lcc on 16/8/30.
//  Copyright © 2016年 early bird international. All rights reserved.
//

#import "ViewController.h"
#import "LCProgressView.h"

@interface ViewController ()


@end

@implementation ViewController{

    LCProgressView *progressView;
    LCProgressView *lineProgressView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    [self creatProgressView];
}


- (void)creatProgressView{

    
    progressView = [LCProgressView progressView:CGRectMake(100, 100, 100, 100) size:CycleStructMake(20, 20)];
    
    //设置 progress 属性
    progressView.progressBgColor = RGB(59, 59, 59);
    progressView.progressColor = [UIColor lightGrayColor];
    progressView.backgroundColor = [UIColor  blackColor];
    
    [progressView setLoadSuccessBlock:^(LCProgressView *progress) {
        
        NSLog(@"加载完成");
        
        
    }];
    
    [self.view addSubview:progressView];
    
    
    lineProgressView = [LCProgressView progressView:CGRectMake(100, 250, 100, 100) size:CycleStructMake(20, 5)];
    
    //设置 progress 属性
    lineProgressView.progressBgColor = RGB(59, 59, 59);
    lineProgressView.progressColor = [UIColor whiteColor];
    lineProgressView.backgroundColor = [UIColor  blackColor];
    
    [lineProgressView setLoadSuccessBlock:^(LCProgressView *progress) {
        
        NSLog(@"加载完成");
        
        
    }];
    
    [self.view addSubview:lineProgressView];
    
    
    
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(100, 500, 200, 30)];
    slider.userInteractionEnabled = YES;
    slider.value = 0.3;
    slider.minimumValue = 0.0;
    slider.maximumValue = 1.0;

    [slider addTarget:self action:@selector(sliderTouch:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:slider];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 550, 60, 30);
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.backgroundColor = [UIColor yellowColor];
    button.layer.borderColor = [[UIColor blackColor] CGColor];
    button.layer.borderWidth = 1;
    button.layer.cornerRadius = 6;
    [button.layer masksToBounds];
    [button setTitle:@"点我动吧" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(animationStart:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}

- (void)animationStart:(UIButton *)button{

    [progressView startAnimation];
    [lineProgressView startAnimation];
}

- (void)sliderTouch:(UISlider *)slider{

    NSLog(@"slider:%f",slider.value);
    
    progressView.progressValue = slider.value;
    lineProgressView.progressValue = slider.value;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
