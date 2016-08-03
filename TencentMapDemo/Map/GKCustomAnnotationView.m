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
//#import "GKCombineAnnotationView.h"
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
//@property (nonatomic, strong) GKCombineAnnotationView *AnnotationView;
@property (nonatomic, strong) GKCallOutAnnotationView *callOutAnnotationView;

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
        
        
        self.callOutAnnotationView = [[[NSBundle mainBundle] loadNibNamed:@"GKCallOutAnnotationView" owner:self options:nil] lastObject];
        self.callOutAnnotationView.frame = CGRectMake(selfBounds.origin.x, selfBounds.origin.y, annotationViewWidth, annotationViewHeight);
        self.callOutAnnotationView.center = CGPointMake(CGRectGetMidX(selfBounds), CGRectGetMidY(selfBounds));
        self.callOutAnnotationView.layer.cornerRadius = annotationViewHeight * 0.5;
        self.callOutAnnotationView.clipsToBounds = YES;
        
        [self.callOutAnnotationView.homeBtn addTarget:self action:@selector(didClickHomeBtn:) forControlEvents:UIControlEventTouchUpInside];
        for(int i = 0; i < _callOutAnnotationView.btnArray.count; i++)
        {
            GKCallOutViewBrandCell *cell = _callOutAnnotationView.btnArray[i];
            cell.callOutBrandBtn.tag = i;
            
            [cell.callOutBrandBtn addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self addSubview:self.callOutAnnotationView];
        
        
    }
    return self;
}


- (void)setType:(AnnotationViewType)type
{
    _type = type;
    
    if(type == AnnotationViewTypeNormal)
    {
//        self.AnnotationView.pageControl.hidden = YES;
        self.callOutAnnotationView.pageControl.hidden = YES;
    }
}

#pragma mark - lazy


#pragma mark - public

- (void)resetUI
{
    self.callOutAnnotationView.hidden = NO;
    
//    self.AnnotationView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    [UIView animateWithDuration:frameScaleDur animations:^{
        
        self.callOutAnnotationView.frame = CGRectMake(selfBounds.origin.x, selfBounds.origin.y, annotationViewWidth, annotationViewHeight);
        self.callOutAnnotationView.center = CGPointMake(CGRectGetMidX(selfBounds), CGRectGetMinY(selfBounds));
        
        [self.callOutAnnotationView hideSubViews];
        
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        [self hideJobCard];
    }];
}


#pragma mark - private


- (void)didClickHomeBtn:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    
    btn.selected = !btn.selected;
    if(btn.selected)
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
    
    for(int i = 0; i < _callOutAnnotationView.btnArray.count; i++)
    {
        GKCallOutViewBrandCell *cell = _callOutAnnotationView.btnArray[i];
        
        CGPoint shopViewPointButton = [cell.callOutBrandBtn convertPoint:point fromView:self];
        
        if([cell.callOutBrandBtn pointInside:shopViewPointButton withEvent:event])
        {
            return cell.callOutBrandBtn;
        }
    }
    
    return result;
}


- (void)callOutCombineAnnotation
{
    [UIView animateWithDuration:scaleMaxDur animations:^{
        self.callOutAnnotationView.transform = CGAffineTransformScale(self.callOutAnnotationView.transform, annotationViewMaxScale, annotationViewMaxScale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:scaleMinDur animations:^{
            self.callOutAnnotationView.transform = CGAffineTransformScale(self.callOutAnnotationView.transform, annotationViewMinScale, annotationViewMinScale);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:frameScaleDur animations:^{
                
                self.callOutAnnotationView.frame = CGRectMake(selfBounds.origin.x, selfBounds.origin.y, annotationViewMaxWidth, annotationViewHeight);
                self.callOutAnnotationView.center = CGPointMake(CGRectGetMidX(selfBounds), CGRectGetMidY(selfBounds));
                
                [self.callOutAnnotationView calloutSubViews:YES];
                
                
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
    [UIView animateWithDuration:scaleMaxDur animations:^{
        self.callOutAnnotationView.transform = CGAffineTransformScale(self.callOutAnnotationView.transform, annotationViewMaxScale, annotationViewMaxScale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:scaleMinDur animations:^{
            self.callOutAnnotationView.transform = CGAffineTransformScale(self.callOutAnnotationView.transform, annotationViewMinScale, annotationViewMinScale);
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
    [UIView animateWithDuration:scaleMaxDur animations:^{
        btn.transform = CGAffineTransformScale(self.callOutAnnotationView.transform, annotationViewMaxScale, annotationViewMaxScale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:scaleMinDur animations:^{
            btn.transform = CGAffineTransformScale(self.callOutAnnotationView.transform, annotationViewMinScale, annotationViewMinScale);
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
    [UIView animateWithDuration:scaleMaxDur animations:^{
        self.callOutAnnotationView.transform = CGAffineTransformScale(self.callOutAnnotationView.transform, annotationViewMaxScale, annotationViewMaxScale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:scaleMinDur animations:^{
            self.callOutAnnotationView.transform = CGAffineTransformScale(self.callOutAnnotationView.transform, annotationViewMinScale, annotationViewMinScale);
        } completion:^(BOOL finished) {
            
            if(self.delegate && [self.delegate respondsToSelector:@selector(shouldPresentJobCardView:)])
            {
                [self.delegate shouldPresentJobCardView:NO];
            }
        }];
    }];
}

@end
