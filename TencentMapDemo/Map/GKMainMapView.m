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
#import "QCircleView+GK_Animation.h"
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
        
        //圆心坐标
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake(39.980161,116.327621);
        //构造圆形，半径单位m
        QCircle *circle = [QCircle circleWithCenterCoordinate:center radius:3000];
        self.userCircleRect = circle.boundingMapRect;
        //添加圆形
        [self.mapView addOverlay:circle];
        
        
        // 设置标注
        QPointAnnotation *annotation = [[QPointAnnotation alloc] init];
        [annotation setCoordinate:CLLocationCoordinate2DMake(39.987161,116.427621)];
        
        GKUserIconViewAnnotation *iconAnnotation = [[GKUserIconViewAnnotation alloc] init];
        [iconAnnotation setCoordinate:CLLocationCoordinate2DMake(39.980161,116.327621)];
        
        //添加标注
        [self.annotations addObject:annotation];
        [self.annotations addObject:iconAnnotation];
        
        [self.mapView addAnnotations:self.annotations];
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
            
            annotationView.image = [UIImage imageNamed:@"subway_station"];
            
            return annotationView;
        }
    }
    
    if ([annotation isKindOfClass:[QPointAnnotation class]]) {
        //添加自定义annotation
        if ([annotation isEqual:[_annotations objectAtIndex:0]]) {
            GKCustomAnnotationView *annotationView = (GKCustomAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndentifier];
            if (annotationView == nil) {
                annotationView = [[GKCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndentifier];
                UIImage *image = [UIImage imageNamed:@"start_point_in_map"];
                annotationView.image = image;
                
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

- (QOverlayView *) mapView:(QMapView *)mapView viewForOverlay:(id<QOverlay>)overlay
{
    if ([overlay isKindOfClass:[QCircle class]]) {
        QCircleView *circleView = [[QCircleView alloc] initWithCircle:overlay];
        
        [circleView gk_AddAnimation];
        
        //设置描边色为黑色
        [circleView setStrokeColor:[UIColor blackColor]];
        //设置填充色为红色
        [circleView setFillColor:[UIColor colorWithRed:0.2472 green:0.5955 blue:0.8759 alpha:0.53]];
        
        
//        [self setNeedsDisplay];
        
        return circleView;
    }
    return nil;
}


- (void)mapView:(QMapView *)mapView didSelectAnnotationView:(QAnnotationView *)view
{
    // 品牌
    if([view isKindOfClass:[GKCustomAnnotationView class]])
    {
        
        id<QAnnotation> annotation = view.annotation;
//        [mapView setCenterCoordinate:annotation.coordinate];
        
        //圆心坐标
        CLLocationCoordinate2D center = annotation.coordinate;
        //构造圆形，半径单位m
        _tapedCircle = [QCircle circleWithCenterCoordinate:center radius:3000];
        //添加圆形
        [mapView addOverlay:_tapedCircle];
        
        CGRect screenRect = [UIScreen mainScreen].bounds;
        CGRect cardRect = CGRectMake(10, screenRect.size.height, screenRect.size.width - 20, 300);
        
        if(!_jobCard)
        {
            _jobCard = [[[NSBundle mainBundle] loadNibNamed:@"GKJobCardView" owner:nil options:nil] firstObject];
            _jobCard.frame = cardRect;
            _jobCard.hidden = NO;
            _jobCard.isVisible = NO;
            [self addSubview:_jobCard];
        }
        
        [UIView animateWithDuration:1.0 animations:^{
            
            _jobCard.transform = CGAffineTransformTranslate(_jobCard.transform, 0, -355);
            
        } completion:^(BOOL finished) {
            _jobCard.isVisible = !_jobCard.isVisible;
        }];
        
    }
    
    // 用户头像
    if([view isKindOfClass:[GKUserIconView class]])
    {
        [self iconViewClicked];
    }
}

- (void)mapView:(QMapView *)mapView didDeselectAnnotationView:(QAnnotationView *)view
{
    // 品牌
    if([view isKindOfClass:[GKCustomAnnotationView class]])
    {
        // 移除圆
        [mapView removeOverlay:_tapedCircle];
        
        CGRect screenRect = [UIScreen mainScreen].bounds;
        CGRect cardRect = CGRectMake(10, screenRect.size.height - 345, screenRect.size.width - 20, 300);
        
        if(!_jobCard)
        {
            _jobCard = [[[NSBundle mainBundle] loadNibNamed:@"GKJobCardView" owner:nil options:nil] firstObject];
            _jobCard.frame = cardRect;
            _jobCard.hidden = NO;
            _jobCard.isVisible = YES;
            [self addSubview:_jobCard];
        }
        
        [UIView animateWithDuration:1.0 animations:^
         {
             if(_jobCard.isVisible)
             {
                 _jobCard.transform = CGAffineTransformTranslate(_jobCard.transform, 0, 355);
                 
             }
             
         } completion:^(BOOL finished){
             
             _jobCard.isVisible = !_jobCard.isVisible;
             
         }];
    }
}

- (void)mapRegionChanged:(QMapView*)mapView
{
    
    QMapRect mapViewRect =[mapView visibleMapRect];
    
    if(_userCircleRect.origin.x < QMapRectGetMaxX(mapViewRect)
       && (_userCircleRect.origin.x + _userCircleRect.size.width) > QMapRectGetMinX(mapViewRect)
       && (_userCircleRect.origin.y + _userCircleRect.size.height) > QMapRectGetMinY(mapViewRect)
       && _userCircleRect.origin.y < QMapRectGetMaxY(mapViewRect)
       )
    {
        NSLog(@"未出屏幕");
    }else
    {
        NSLog(@"出屏幕");
    }
}


#pragma mark - CustomAnnotationViewDelegate


#pragma mark - private
- (void)iconViewClicked
{
    // 点击头像
}

@end
