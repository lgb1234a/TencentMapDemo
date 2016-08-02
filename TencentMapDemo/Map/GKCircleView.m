//
//  GKCircleView.m
//  TencentMapDemo
//
//  Created by chenyn on 16/8/2.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import "GKCircleView.h"

@implementation GKCircleView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.37].CGColor);
    
    CGContextAddArc(context, rect.origin.x + rect.size.width * 0.5, rect.origin.y + rect.size.height * 0.5, rect.size.width * 0.5, 0, 2 * M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathFill); //绘制路径
    
    [self addAnimation];
}

- (void)addAnimation
{
    CAKeyframeAnimation *frameScale = [CAKeyframeAnimation animation];
    frameScale.delegate = self;
    frameScale.keyPath = @"transform.scale";
    
    frameScale.duration = 2.0;
    frameScale.repeatCount = MAXFLOAT;
    frameScale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    double gk_maxScale = 1.3;
    double gk_minScale = 1.0;
    frameScale.values = @[@(gk_minScale), @(gk_maxScale)];
    [self.layer addAnimation:frameScale forKey:@"scale"];
    
    
    CAKeyframeAnimation *layerOpacity = [CAKeyframeAnimation animation];
    layerOpacity.keyPath = @"opacity";
    
    layerOpacity.duration = 2.0;
    layerOpacity.repeatCount = MAXFLOAT;
    layerOpacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    
    layerOpacity.values = @[@1.0, @0.0];
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
