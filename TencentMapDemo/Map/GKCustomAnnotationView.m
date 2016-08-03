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
#import "GKCombineAnnotationView.h"
#import "GKCallOutAnnotationView.h"

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
@property (nonatomic, strong) GKCombineAnnotationView *AnnotationView;
@property (nonatomic, strong) GKCallOutAnnotationView *callOutAnnotationView;

@end

#define annotationViewWidth 60
#define annotationViewHeight 65
#define selfBounds self.bounds
#define annotationViewMaxWidth 225
#define annotationViewMaxScale 1.1
#define annotationViewMinScale (10 / 11.0)

@implementation GKCustomAnnotationView


#pragma mark - life

- (id)initWithAnnotation:(id<QAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        self.image = nil;
        self.backgroundColor = [UIColor clearColor];
        
//        self.circleView = [[GKCircleView alloc] initWithFrame:CGRectMake(selfBounds.origin.x, selfBounds.origin.y, 80, 80)];
//        self.circleView.center = CGPointMake(selfBounds.origin.x + selfBounds.size.width * 0.5, selfBounds.origin.y + selfBounds.size.height * 0.5);
//        self.circleView.hidden = YES;
        
//        [self addSubview:self.circleView];
        
        self.AnnotationView = [[[NSBundle mainBundle] loadNibNamed:@"GKCombineAnnotationView" owner:self options:nil] lastObject];
        self.AnnotationView.frame = CGRectMake(selfBounds.origin.x, selfBounds.origin.y, annotationViewWidth, annotationViewHeight);
        self.AnnotationView.center = CGPointMake(CGRectGetMidX(selfBounds), CGRectGetMidY(selfBounds));
        self.AnnotationView.layer.cornerRadius = annotationViewHeight * 0.5;
        self.AnnotationView.clipsToBounds = YES;
        
        [self addSubview:self.AnnotationView];
        
        [self.AnnotationView.iconBtn addTarget:self action:@selector(clickedAnnotation:) forControlEvents:UIControlEventTouchUpInside];
        [self.AnnotationView.btn_1 addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.AnnotationView.btn_2 addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.AnnotationView.btn_3 addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
//        self.callOutAnnotationView = [[[NSBundle mainBundle] loadNibNamed:@"GKCombineAnnotationView" owner:self options:nil] lastObject];
//        self.callOutAnnotationView.frame = CGRectMake(selfBounds.origin.x, selfBounds.origin.y, annotationViewWidth, annotationViewHeight);
//        self.callOutAnnotationView.center = CGPointMake(CGRectGetMidX(selfBounds), CGRectGetMidY(selfBounds));
//        self.callOutAnnotationView.layer.cornerRadius = annotationViewHeight * 0.5;
//        self.callOutAnnotationView.clipsToBounds = YES;
//        
//        [self addSubview:self.callOutAnnotationView];
        
        
    }
    return self;
}


- (void)setType:(AnnotationViewType)type
{
    _type = type;
    
    if(type == AnnotationViewTypeNormal)
    {
        self.AnnotationView.pageControl.hidden = YES;
    }
}

#pragma mark - lazy


#pragma mark - public

- (void)resetUI
{
    self.AnnotationView.hidden = NO;
    
//    self.AnnotationView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.AnnotationView.frame = CGRectMake(selfBounds.origin.x, selfBounds.origin.y, annotationViewWidth, annotationViewHeight);
        self.AnnotationView.center = CGPointMake(CGRectGetMidX(selfBounds), CGRectGetMinY(selfBounds));
        
        self.AnnotationView.leadingBetBtn_1AndScroll.priority = UILayoutPriorityDefaultHigh;
        self.AnnotationView.leadingBetBtn_2AndScroll.priority = UILayoutPriorityDefaultHigh;
        self.AnnotationView.leadingBetBtn_3AndScroll.priority = UILayoutPriorityDefaultHigh;
        
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        [self hideJobCard];
    }];
}


#pragma mark - private

- (void)clickedAnnotation:(id)sender
{
    self.AnnotationView.iconBtn.selected = !self.AnnotationView.iconBtn.selected;
    
    if(self.AnnotationView.iconBtn.selected)
    {
        if(self.type == AnnotationViewTypeNormal)
        {
            [self presentJobCard];
        
        }else
        {
            [self callOutCombineAnnotation];
        }
        
    }else
    {
        if(self.type == AnnotationViewTypeNormal)
        {
            [self hideJobCard];
        }else
        {
            [self resetUI];
        }
    }
}

- (void)didclickBtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    switch (btn.tag) {
        case 1:
        {
            NSLog(@"click btn1");
            [self presentJobCardWithBtn:btn];
        }
            break;
        case 2:
        {
            NSLog(@"click btn2");
            [self presentJobCardWithBtn:btn];
        }
            break;
        case 3:
        {
            NSLog(@"click btn3");
            [self presentJobCardWithBtn:btn];
        }
            break;
            
        default:
            break;
    }
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return NO;
}

// 点击大头针
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *result = [super hitTest:point withEvent:event];
    
    CGPoint shopViewPointButton = [_AnnotationView.iconBtn convertPoint:point fromView:self];
    
    if ([_AnnotationView.iconBtn pointInside:shopViewPointButton withEvent:event]) {
        return _AnnotationView.iconBtn;
    }
    
    shopViewPointButton = [_AnnotationView.btn_1 convertPoint:point fromView:self];
    if ([_AnnotationView.btn_1 pointInside:shopViewPointButton withEvent:event]) {
        return _AnnotationView.btn_1;
    }
    
    shopViewPointButton = [_AnnotationView.btn_2 convertPoint:point fromView:self];
    if ([_AnnotationView.btn_2 pointInside:shopViewPointButton withEvent:event]) {
        return _AnnotationView.btn_2;
    }
    
    shopViewPointButton = [_AnnotationView.btn_3 convertPoint:point fromView:self];
    if ([_AnnotationView.btn_3 pointInside:shopViewPointButton withEvent:event]) {
        return _AnnotationView.btn_3;
    }
    
    return result;
}


- (void)callOutCombineAnnotation
{
    [UIView animateWithDuration:0.2 animations:^{
        self.AnnotationView.transform = CGAffineTransformScale(self.AnnotationView.transform, annotationViewMaxScale, annotationViewMaxScale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.AnnotationView.transform = CGAffineTransformScale(self.AnnotationView.transform, annotationViewMinScale, annotationViewMinScale);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                
                self.AnnotationView.frame = CGRectMake(selfBounds.origin.x, selfBounds.origin.y, annotationViewMaxWidth, annotationViewHeight);
                self.AnnotationView.center = CGPointMake(CGRectGetMidX(selfBounds), CGRectGetMidY(selfBounds));
                
                self.AnnotationView.leadingBetBtn_1AndScroll.priority = UILayoutPriorityDefaultLow;
                self.AnnotationView.leadingBetBtn_2AndScroll.priority = UILayoutPriorityDefaultLow;
                self.AnnotationView.leadingBetBtn_3AndScroll.priority = UILayoutPriorityDefaultLow;
                
                
                [self layoutIfNeeded];
            } completion:^(BOOL finished) {
                
                if(self.delegate && [self.delegate respondsToSelector:@selector(moveAnnotationToMapCenter:)])
                {
                    __weak typeof(self) wself = self;
                    [self.delegate moveAnnotationToMapCenter:wself.annotation];
                }
            }];
        }];
    }];
}


- (void)presentJobCard
{
    [UIView animateWithDuration:0.2 animations:^{
        self.AnnotationView.transform = CGAffineTransformScale(self.AnnotationView.transform, annotationViewMaxScale, annotationViewMaxScale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.AnnotationView.transform = CGAffineTransformScale(self.AnnotationView.transform, annotationViewMinScale, annotationViewMinScale);
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

- (void)presentJobCardWithBtn:(UIButton *)btn
{
    [UIView animateWithDuration:0.2 animations:^{
        btn.transform = CGAffineTransformScale(self.AnnotationView.transform, annotationViewMaxScale, annotationViewMaxScale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            btn.transform = CGAffineTransformScale(self.AnnotationView.transform, annotationViewMinScale, annotationViewMinScale);
        } completion:^(BOOL finished) {
            
            if(self.delegate && [self.delegate respondsToSelector:@selector(shouldPresentJobCardView:)])
            {
                [self.delegate shouldPresentJobCardView:YES];
            }
        }];
    }];
}

- (void)hideJobCard
{
    [UIView animateWithDuration:0.2 animations:^{
        self.AnnotationView.transform = CGAffineTransformScale(self.AnnotationView.transform, annotationViewMaxScale, annotationViewMaxScale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.AnnotationView.transform = CGAffineTransformScale(self.AnnotationView.transform, annotationViewMinScale, annotationViewMinScale);
        } completion:^(BOOL finished) {
            
            if(self.delegate && [self.delegate respondsToSelector:@selector(shouldPresentJobCardView:)])
            {
                [self.delegate shouldPresentJobCardView:NO];
            }
        }];
    }];
}

@end
