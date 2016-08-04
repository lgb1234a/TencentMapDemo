//
//  CustomAnnotationView.m
//  TencentMapDemo
//
//  Created by chenyn on 16/7/18.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import "GKCustomAnnotationView.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CAAnimation.h>
#import "GKUserIconView.h"
#import "QPointAnnotation.h"
#import "GKMapViewSingleTon.h"
#import "GKCircleView.h"
#import "GKJobCardView.h"
#import "GKMaskAnnotationView.h"
#import "GKSingleAnnotationView.h"

@interface GKCustomAnnotationView ()
{
    double timeLast;
    CAKeyframeAnimation *_frameScale;
    CAKeyframeAnimation *_layerOpacity;
}

@property (nonatomic, strong) UIButton *iconView;

@property (nonatomic, strong) GKCircleView *circleView;
@property (nonatomic, strong) GKJobCardView *jobCard;
@property (nonatomic, strong) UIButton *iconBtn;
@property (nonatomic, strong) GKSingleAnnotationView *singleAnnotationView;

@end

#define annotationViewWidth 60
#define annotationViewHeight 65
#define selfBounds self.bounds
#define annotationViewMaxWidth 225
#define annotationViewMaxScale 1.1
#define annotationViewMinScale (10 / 11.0)
#define scaleMaxDur 0.2
#define scaleMinDur 0.1
#define frameScaleDur 0.5

@implementation GKCustomAnnotationView

#pragma mark - life

- (id)initWithAnnotation:(id<QAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        self.image = nil;
        self.backgroundColor = [UIColor clearColor];
        
        self.singleAnnotationView = [[[NSBundle mainBundle] loadNibNamed:@"GKSingleAnnotationView" owner:nil options:nil] lastObject];
        self.singleAnnotationView.frame = CGRectMake(selfBounds.origin.x, selfBounds.origin.y, annotationViewWidth, annotationViewHeight);
        self.singleAnnotationView.center = CGPointMake(CGRectGetMidX(selfBounds), CGRectGetMidY(selfBounds));
        self.singleAnnotationView.layer.cornerRadius = annotationViewHeight * 0.5;
        self.singleAnnotationView.clipsToBounds = YES;
        
        [self.singleAnnotationView.annotationBtn addTarget:self action:@selector(didClickHomeBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.singleAnnotationView];
    }
    return self;
}


- (void)setType:(AnnotationViewType)type
{
    _type = type;
}

#pragma mark - lazy


#pragma mark - public


#pragma mark - private

// 点击标注的按钮
- (void)didClickHomeBtn:(id)sender
{
    if(self.type == AnnotationViewTypeNormal)
    {
        // 非聚合岗位，展示岗位详情卡片
        [self presentJobCard];
        
    }else
    {
        // 聚合岗位，展开聚合标注
        [self callOutCombineAnnotation];
    }
    
}

// 拦截点击事件
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return NO;
}

// 拦截事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *result = [super hitTest:point withEvent:event];
    
    CGPoint btnPoint = [_singleAnnotationView.annotationBtn convertPoint:point fromView:self];
    
    
    if([_singleAnnotationView.annotationBtn pointInside:btnPoint withEvent:event])
    {
        return _singleAnnotationView.annotationBtn;
    }
    
    return result;
}

// 打开聚合标注
- (void)callOutCombineAnnotation
{
    
//    if(self.delegate && [self.delegate respondsToSelector:@selector(moveAnnotationToMapCenter:)])
//    {
//        __weak typeof(self) wself = self;
//        [self.delegate moveAnnotationToMapCenter:wself.annotation];
//    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(addMaskAnnotationView:withAnnotationRect:)])
    {
        [self.delegate addMaskAnnotationView:self.annotation withAnnotationRect:selfBounds];
    }
    
}

// 通知代理显示岗位视图
- (void)presentJobCard
{
    [UIView animateWithDuration:scaleMaxDur animations:^{
        self.singleAnnotationView.transform = CGAffineTransformScale(self.singleAnnotationView.transform, annotationViewMaxScale, annotationViewMaxScale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:scaleMinDur animations:^{
            self.singleAnnotationView.transform = CGAffineTransformScale(self.singleAnnotationView.transform, annotationViewMinScale, annotationViewMinScale);
        } completion:^(BOOL finished) {
            
            if(self.delegate && [self.delegate respondsToSelector:@selector(shouldPresentJobCardView:)])
            {
                [self.delegate shouldPresentJobCardView:YES];
            }
            
            if(self.delegate && [self.delegate respondsToSelector:@selector(moveAnnotationToMapCenter:)])
            {
                __weak typeof(self) wself = self;
                [self.delegate moveAnnotationToMapCenter:wself.annotation];
            }
        }];
    }];
}

// 通知代理隐藏岗位视图
- (void)hideJobCard
{
    [UIView animateWithDuration:scaleMaxDur animations:^{
        self.singleAnnotationView.transform = CGAffineTransformScale(self.singleAnnotationView.transform, annotationViewMaxScale, annotationViewMaxScale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:scaleMinDur animations:^{
            self.singleAnnotationView.transform = CGAffineTransformScale(self.singleAnnotationView.transform, annotationViewMinScale, annotationViewMinScale);
        } completion:^(BOOL finished) {
            
            if(self.delegate && [self.delegate respondsToSelector:@selector(shouldPresentJobCardView:)])
            {
                [self.delegate shouldPresentJobCardView:NO];
            }
        }];
    }];
}

@end
