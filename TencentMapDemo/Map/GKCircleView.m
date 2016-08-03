//
//  GKCircleView.m
//  TencentMapDemo
//
//  Created by chenyn on 16/8/2.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import "GKCircleView.h"


#define frameScaleDur 2.0
#define layerOpacityDur  2.0
#define frameScaleMax  1.3
#define frameScaleMin  1.0
#define layerOpacityMax 1.0
#define layerOpacityMin 0.0


@implementation GKCircleView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.37].CGColor);
    
    CGContextAddArc(context, CGRectGetMidX(rect), CGRectGetMidY(rect), rect.size.width * 0.5, 0, 2 * M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFill); //绘制路径
    
    [self addAnimation];
}

- (void)addAnimation
{
    CAKeyframeAnimation *frameScale = [CAKeyframeAnimation animation];
    frameScale.delegate = self;
    frameScale.keyPath = @"transform.scale";
    
    frameScale.duration = frameScaleDur;
    frameScale.repeatCount = MAXFLOAT;
    frameScale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    frameScale.values = @[@(frameScaleMin), @(frameScaleMax)];
    [self.layer addAnimation:frameScale forKey:@"scale"];
    
    
    CAKeyframeAnimation *layerOpacity = [CAKeyframeAnimation animation];
    layerOpacity.keyPath = @"opacity";
    
    layerOpacity.duration = layerOpacityDur;
    layerOpacity.repeatCount = MAXFLOAT;
    layerOpacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    
    layerOpacity.values = @[@(layerOpacityMax), @(layerOpacityMin)];
    [self.layer addAnimation:layerOpacity forKey:@"opacity"];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


@end
