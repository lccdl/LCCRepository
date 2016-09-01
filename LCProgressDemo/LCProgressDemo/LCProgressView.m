//
//  LCProgressView.m
//  LCProgressDemo
//
//  Created by lcc on 16/8/30.
//  Copyright © 2016年 early bird international. All rights reserved.
//

#import "LCProgressView.h"

#define DEFAULT_RADIUS 20
#define DEFAULT_STORKE_WIDTH 2

#define DRAW_AIMATION_TIME 2

@interface LCProgressView ()

@end


@implementation LCProgressView{

    CAShapeLayer *backShapeLayer;
    CAShapeLayer *foreShapeLayer;
    
}



#pragma -mark- * 创建界面
+ (instancetype)progressView:(CGRect)frame size:(CycleStruct)size{

    return [[self alloc]initWithFrame:frame withSize:(CycleStruct)size];
}




- (instancetype)initWithFrame:(CGRect)frame withSize:(CycleStruct)size{

    if (self = [super initWithFrame:frame]) {
        
        self.cycleWidth = size.cycleWidth;
        self.radius = size.radius;
        
        [self creatView];
        
    }
    
    return self;
}




/**
 *  创建圆环背景
 */
- (void)creatView{
    
    //背景色
    self.backgroundColor = [UIColor blackColor];
    self.layer.cornerRadius = 6;
    
    CAShapeLayer *backLayer = [self creatCycleView];
    backLayer.strokeColor = _progressColor ? [_progressColor CGColor] : [[UIColor colorWithRed:59/255.0 green:59/255.0 blue:59/255.0 alpha:1]CGColor];
    backLayer.fillColor = _progressBgColor ? [_progressBgColor CGColor] : [[UIColor clearColor]CGColor];
    
    backShapeLayer = backLayer;
    
    [self.layer addSublayer:backLayer];
    
    CAShapeLayer *foreLayer = [self creatCycleView];
    foreLayer.strokeColor = _progressColor ? [_progressColor CGColor] : [[UIColor whiteColor]CGColor];
    foreLayer.fillColor = [[UIColor clearColor]CGColor];
    foreLayer.strokeEnd = 0.3;
    foreLayer.cornerRadius = 2;
    
    //绘制线条的风格
    if (self.cycleWidth != self.radius) {
     
        foreLayer.lineCap = kCALineCapRound;
    }
    
    
    foreShapeLayer = foreLayer;
    [self.layer addSublayer:foreLayer];
    
    
}


- (CAShapeLayer *)creatCycleView{
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    
    //storkeWidth 的宽度的中点位于半径的轨迹上，绘制的时候由轨迹路线内外扩展绘制，
    //所以真是绘制长度为真实长度减去轨迹长度的一半
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0) radius:_radius ? _radius - _cycleWidth * 0.5 : _radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    
    layer.lineWidth = _cycleWidth ? _cycleWidth : DEFAULT_STORKE_WIDTH;
    layer.path = [path CGPath];

    
    return layer;
}

- (void)drawCycle{

    //创建动画实例
    CABasicAnimation *drawCycleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawCycleAnimation.duration = DRAW_AIMATION_TIME;
    drawCycleAnimation.repeatCount = 1;
    drawCycleAnimation.delegate = self;
    
    //设置动画内容的起始值与结束值
    drawCycleAnimation.fromValue = [NSNumber numberWithFloat:0.3];
    drawCycleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    
    //动画时间速度
    drawCycleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [foreShapeLayer addAnimation:drawCycleAnimation forKey:@"drawCircleAnimation"];
    
    //创建缩放动画
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    basicAnimation.duration = DRAW_AIMATION_TIME;
    basicAnimation.repeatCount = 1;
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

    CATransform3D startTransForm = CATransform3DMakeScale(0, 0, 1);
    CATransform3D endTransForm = CATransform3DMakeRotation(0, 0, 0, 1);
    
    basicAnimation.fromValue = [NSValue valueWithCATransform3D:startTransForm];
    basicAnimation.toValue = [NSValue valueWithCATransform3D:endTransForm];
    
    [foreShapeLayer addAnimation:basicAnimation forKey:@"startTransform"];
    
    
}

- (void)startAnimation{

    [self drawCycle];
}


#pragma -mark- 动画开始与动画结束的代理
- (void)animationDidStart:(CAAnimation *)anim{

    NSLog(@"动画开始");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{

    NSLog(@"动画结束");
    self.loadSuccessBlock(self);
}


#pragma -mark- * setter and getter

- (void)setProgressColor:(UIColor *)progressColor{

    _progressColor = progressColor;
    foreShapeLayer.strokeColor = [progressColor CGColor];
    
}

- (void)setProgressBgColor:(UIColor *)progressBgColor{

    _progressBgColor = progressBgColor;
    backShapeLayer.strokeColor = [progressBgColor CGColor];
}


- (void)setProgressValue:(float)progressValue{

    _progressValue = progressValue;
    
    foreShapeLayer.strokeEnd = progressValue;
    
    if (self.loadSuccessBlock && progressValue == 1) {
        self.loadSuccessBlock(self);
    }

}

- (void)setLoadSuccessBlock:(void (^)(LCProgressView * progressView))loadSuccessBlock{

    _loadSuccessBlock = loadSuccessBlock;
}



@end
