//
//  CustomAnnotationView.m
//  TencentMapDemo
//
//  Created by chenyn on 16/7/18.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import "GKCustomAnnotationView.h"
#import "GKCustomCalloutView.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CAAnimation.h>
#import "GKUserIconView.h"
#import "QPointAnnotation.h"
#import "GKMapViewSingleTon.h"
#import "GKCombineAnnotationCallOutView.h"

@interface GKCustomAnnotationView ()
{
    double timeLast;
    CAKeyframeAnimation *_frameScale;
    CAKeyframeAnimation *_layerOpacity;
}

@property (nonatomic, strong) UIImage *imageCallout;
@property (nonatomic, strong) NSString *btnTitle;
@property (nonatomic, strong) id btnTarget;
@property (nonatomic) UIControlState btnState;
@property (nonatomic) SEL btnAction;
@property (nonatomic) UIControlEvents btnControlEvents;
@property (nonatomic, strong) GKCustomCalloutView *customCalloutView;
//@property (nonatomic, strong) CircleView *backView;
@property (nonatomic, strong) UIButton *iconView;
@property (nonatomic, strong) GKCombineAnnotationCallOutView *combineAnnotationCallOutView;


@end

@implementation GKCustomAnnotationView

#pragma mark - lazy
- (UIButton *)iconView
{
    if(!_iconView)
    {
        CGPoint origin = self.bounds.origin;
        self.iconView = [[UIButton alloc] initWithFrame:CGRectMake(origin.x, origin.y, 80, 80)];
        self.iconView.center = CGPointMake(self.center.x + self.bounds.size.width * 0.5, self.center.y + self.bounds.size.height * 0.5);
        [self.iconView setImage:[UIImage imageNamed:@"subway_station"] forState:UIControlStateNormal];
        
        [self.iconView addTarget:self action:@selector(iconViewClicked:) forControlEvents:UIControlEventTouchUpInside];
      
//      [GKMapViewSingleTon sharedInstance].userIconRect = CGRectMake(self.frame.origin.x,
//                                                                    self.frame.origin.y,
//                                                                    80,
//                                                                    80);
    }
    
    return _iconView;
}

#pragma mark - public

- (void)setIconViewImg:(UIImage *)image
{
  [self.iconView setImage:image forState:UIControlStateNormal];
}


-(void)setCalloutImage:(UIImage *)image {
    _imageCallout = image;
}

-(void)setCalloutBtnTitle:(NSString *)title
                 forState:(UIControlState)state {
    _btnTitle = title;
}

-(void)addCalloutBtnTarget:(id)target
                    action:(SEL)action
          forControlEvents:(UIControlEvents)events {
    _btnTarget = target;
    _btnAction = action;
    _btnControlEvents = events;
}

#pragma mark - private

-(void)setSelected:(BOOL)selected {
    [self setSelected:selected animated:NO];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {

  
    if (self.selected == selected) {
        return;
    }
    if (selected) {
      
      // 添加动画
      
      //需要弹出callout的时候才开始初始化CalloutView
      if (_combineAnnotationCallOutView == nil) {
        
        _combineAnnotationCallOutView = [[[NSBundle mainBundle] loadNibNamed:@"GKCombineAnnotationCallOutView" owner:nil options:nil] lastObject];
        
        _combineAnnotationCallOutView.center =CGPointMake(CGRectGetWidth(self.bounds) / 2,
                                                          -CGRectGetHeight(_combineAnnotationCallOutView.bounds)/2);
        
      }
      [self addSubview:_combineAnnotationCallOutView];
      
    } else {
      
      
    }
  
    [super setSelected:selected animated:animated];
}


- (void)iconViewClicked:(id)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(iconViewClicked)])
    {
        [self.delegate iconViewClicked];
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    // sdk内的annotation点击到图标返回YES,否则NO
    BOOL inside = [super pointInside:point withEvent:event];
  
    if (!inside)
    {
        /* Callout existed. */
        if (self.selected && self.customCalloutView.superview)
        {
            CGPoint pointInCallout = [self convertPoint:point toView:self.customCalloutView];
            
            inside = CGRectContainsPoint(self.customCalloutView.bounds, pointInCallout);
        }
    }
    
    return inside;
}


- (void)animationDidStart:(CAAnimation *)anim
{
  NSLog(@"开始");
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
  NSLog(@"停止");
}


BOOL isCoordinateCoincided(CLLocationCoordinate2D firstCoor, CLLocationCoordinate2D secondCoor)
{
  if(firstCoor.latitude == secondCoor.latitude  &&  firstCoor.longitude == secondCoor.longitude)
  {
    return YES;
  }
  return NO;
}

- (BOOL)isTapedUserIconViewWithTapedCoordinate:(CLLocationCoordinate2D)tapCoor
{
  return NO;
}

@end
