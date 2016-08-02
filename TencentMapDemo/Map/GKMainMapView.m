//
//  GKMainMapView.m
//  TencentMapDemo
//
//  Created by chenyn on 16/7/27.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import "GKMainMapView.h"
#import "QMapKit.h"
#import "GKMapView.h"
#import "GKUserIconView.h"
#import "GKCustomAnnotationView.h"
#import "GKUserIconViewAnnotation.h"
#import "GKUserIconView.h"
#import "GKMapViewSingleTon.h"
#import "CALayer+GKAnimation.h"
#import "GKJobCardView.h"

@interface GKMainMapView () <QMapViewDelegate, GKCustomAnnotationViewDelegate>

@property (nonatomic, strong) GKMapView *mapView;

@property (nonatomic, strong) NSMutableArray *annotations;

@property (nonatomic, strong) GKJobCardView *jobCard;

@property (nonatomic, strong) QCircle *userCircle;

@property (nonatomic, strong) QCircle *tapedCircle;

@property (nonatomic, assign) QMapRect userCircleRect;

@end

@implementation GKMainMapView

#pragma mark - lazy
- (NSMutableArray *)annotations
{
    if(!_annotations)
    {
        self.annotations = [NSMutableArray array];
    }
    return _annotations;
}

- (void)buildJobCardView
{
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGRect cardRect = CGRectMake(10, screenRect.size.height, screenRect.size.width - 20, 300);
    if(!_jobCard)
    {
        _jobCard = [[[NSBundle mainBundle] loadNibNamed:@"GKJobCardView" owner:nil options:nil] firstObject];
        _jobCard.frame = cardRect;
        _jobCard.hidden = YES;
        _jobCard.isVisible = NO;
        [self addSubview:_jobCard];
    }
}

#pragma mark - life

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.mapView = [[GKMapView alloc] initWithFrame:self.bounds];
        self.mapView.hideAccuracyCircle = YES;
        self.mapView.delegate = self;
        [self addSubview:self.mapView];
        
        // 设置地图中心
        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(39.920269,116.390533)];
        // 设置缩放大小
        [self.mapView setZoomLevel:10];
        
        
        // 设置标注
        QPointAnnotation *annotation = [[QPointAnnotation alloc] init];
        [annotation setCoordinate:CLLocationCoordinate2DMake(39.987161,116.427621)];
        
        GKUserIconViewAnnotation *iconAnnotation = [[GKUserIconViewAnnotation alloc] init];
        [iconAnnotation setCoordinate:CLLocationCoordinate2DMake(39.980161,116.227621)];
        
        //添加标注
        [self.annotations addObject:annotation];
        [self.annotations addObject:iconAnnotation];
        
        [self.mapView addAnnotations:self.annotations];
        
        [self buildJobCardView];
        
    }
    return self;
}


#pragma mark - QMapViewDelegate
- (QAnnotationView *)mapView:(QMapView *)mapView
           viewForAnnotation:(id<QAnnotation>)annotation
{
    static NSString *customReuseIndentifier = @"custReuseIdentifieer";
    static NSString *userIconReuseIdentifier = @"userIcon";
    
    // 用户头像
    if ([annotation isKindOfClass:[GKUserIconViewAnnotation class]]) {
        
        GKUserIconView *annotationView = (GKUserIconView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:userIconReuseIdentifier];
        
        
        if(!annotationView)
        {
            annotationView = [[GKUserIconView alloc] initWithAnnotation:annotation reuseIdentifier:userIconReuseIdentifier];
            
            return annotationView;
        }
    }
    
    if ([annotation isKindOfClass:[QPointAnnotation class]]) {
        //添加自定义annotation
        if ([annotation isEqual:[_annotations objectAtIndex:0]]) {
            GKCustomAnnotationView *annotationView = (GKCustomAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndentifier];
            if (annotationView == nil) {
                annotationView = [[GKCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndentifier];
                annotationView.delegate = self;
                
                return annotationView;
            }
        }
    }
    
    return nil;
}

//<QMapViewDelegate >中的定位回调函数
- (void)mapView:(QMapView *)mapView didUpdateUserLocation:(QUserLocation *)userLocation {
    NSLog(@"latitude:%f, longitude:%f", userLocation.location.latitude, userLocation.location.longitude);
}


- (void)mapView:(QMapView *)mapView didSelectAnnotationView:(QAnnotationView *)view
{
    
}

- (void)mapView:(QMapView *)mapView didDeselectAnnotationView:(QAnnotationView *)view
{
    
}

- (void)mapRegionChanged:(QMapView*)mapView
{
    
    QMapRect mapViewRect =[mapView visibleMapRect];
    
    if(QMapRectGetMinX(_userCircleRect) > QMapRectGetMaxX(mapViewRect)
       || QMapRectGetMaxX(_userCircleRect) < QMapRectGetMinX(mapViewRect)
       || QMapRectGetMinY(_userCircleRect) > QMapRectGetMaxY(mapViewRect)
       || QMapRectGetMaxY(_userCircleRect) < QMapRectGetMinY(mapViewRect)
       )
    {
        NSLog(@"出屏幕");
    }else
    {
        NSLog(@"未出屏幕");
    }
}

#pragma mark - CustomAnnotationViewDelegate

- (void)shouldPresentJobCardView:(BOOL)shouldPresent
{
    if(shouldPresent)
    {
        [self addCardView];
    }else
    {
        [self removewCardView];
    }
}

#pragma mark - private

- (void)didTapMapView:(UIGestureRecognizer *)gesture
{
    
}

- (void)addCardView
{
    self.jobCard.hidden = NO;
    [UIView animateWithDuration:1.0 animations:^{
        
        self.jobCard.transform = CGAffineTransformTranslate(self.jobCard.transform, 0, -355);
        
    } completion:^(BOOL finished) {
        self.jobCard.isVisible = !self.jobCard.isVisible;
    }];
}

- (void)removewCardView
{
    [UIView animateWithDuration:1.0 animations:^
     {
         if(self.jobCard.isVisible)
         {
             self.jobCard.transform = CGAffineTransformTranslate(self.jobCard.transform, 0, 355);
             
         }
         
     } completion:^(BOOL finished){
         
         self.jobCard.isVisible = !self.jobCard.isVisible;
         self.jobCard.hidden = YES;
     }];
}

@end
