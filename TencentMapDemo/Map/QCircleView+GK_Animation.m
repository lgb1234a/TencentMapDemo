//
//  QCircleView+GK_Animation.m
//  RNCandidateProj
//
//  Created by chenyn on 16/7/28.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "QCircleView+GK_Animation.h"

@implementation QCircleView (GK_Animation)

- (void)gk_AddAnimation
{
  CAKeyframeAnimation *frameScale = [CAKeyframeAnimation animation];
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
  
  [self setNeedsDisplay];
}


@end
