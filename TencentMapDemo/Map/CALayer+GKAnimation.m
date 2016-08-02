//
//  CALayer+GKAnimation.m
//  TencentMapDemo
//
//  Created by chenyn on 16/8/1.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import "CALayer+GKAnimation.h"

@implementation CALayer (GKAnimation)

- (void)gk_AddAnimation
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
    [self addAnimation:frameScale forKey:@"scale"];
    
    
    CAKeyframeAnimation *layerOpacity = [CAKeyframeAnimation animation];
    layerOpacity.keyPath = @"opacity";
    
    layerOpacity.duration = 2.0;
    layerOpacity.repeatCount = MAXFLOAT;
    layerOpacity.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    
    layerOpacity.values = @[@1.0, @0.0];
    [self addAnimation:layerOpacity forKey:@"opacity"];
    
    [self setNeedsDisplay];
}


- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"开始");
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"停止");
}


@end
