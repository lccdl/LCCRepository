//
//  LCProgressView.h
//  LCProgressDemo
//
//  Created by lcc on 16/8/30.
//  Copyright © 2016年 early bird international. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CG_INLINE static inline
#define RGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]

/*
 若想创建圆饼状的进度条，可以让 radius 与 cycleWidth 相等即可
 radius: 绘制中心到绘制边之间的半径距离
 cycleWidth: 绘制进度条的宽度
 */

typedef struct {

    CGFloat radius;  //半径（距离中心点位置距离）
    CGFloat cycleWidth; //进度条宽度
    
}CycleStruct;


CG_INLINE CycleStruct
CycleStructMake(CGFloat radius,CGFloat cycleWidth){

    CycleStruct cycleStruct;
    
    cycleStruct.radius = radius;
    cycleStruct.cycleWidth = cycleWidth;
    
    return cycleStruct;
}


@interface LCProgressView : UIView

@property (nonatomic,strong) CAShapeLayer *backCircle;

//进度宽度
@property (nonatomic,assign) float cycleWidth;

//进度半径
@property (nonatomic,assign) float radius;

//进度颜色
@property (nonatomic,strong) UIColor *progressColor;

//进度背景色
@property (nonatomic,strong) UIColor *progressBgColor;


//进度值
@property (nonatomic,assign) float progressValue;

//加载成功后 Block
@property (nonatomic,copy) void (^loadSuccessBlock)(LCProgressView *progressView);


+ (instancetype)progressView:(CGRect)frame size:(CycleStruct)size;

- (void)setLoadSuccessBlock:(void (^)(LCProgressView *progressView))loadSuccessBlock;

- (void)startAnimation;

@end
