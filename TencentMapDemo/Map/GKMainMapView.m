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
#import "GKJobCardView.h"
#import "GKBackgroundAnnotation.h"
#import "GKBackgroundAnnotationView.h"

@interface GKMainMapView () <QMapViewDelegate, GKCustomAnnotationViewDelegate>

@property (nonatomic, strong) GKMapView *mapView;

@property (nonatomic, strong) NSMutableArray *annotations;

@property (nonatomic, strong) GKJobCardView *jobCard;

@property (nonatomic, strong) QCircle *userCircle;

@property (nonatomic, strong) QCircle *tapedCircle;

@property (nonatomic, assign) CLLocationCoordinate2D userCircleCoordinate;

@property (nonatomic, strong) UIButton *userIconBtn;

@end


#define screenRect [UIScreen mainScreen].bounds
#define  jobCardMargin  10
#define  jobCardHeight  280
#define userIconBtnMargin 10
#define userIconWidth    60
#define userIconHeight   60
#define tabbarHeight     50
#define tabbarTopMargin  5

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
    
    CGRect cardRect = CGRectMake(jobCardMargin, screenRect.size.height, screenRect.size.width - 2 * jobCardMargin, jobCardHeight);
    if(!_jobCard)
    {
        _jobCard = [[[NSBundle mainBundle] loadNibNamed:@"GKJobCardView" owner:nil options:nil] firstObject];
        _jobCard.frame = cardRect;
        _jobCard.hidden = YES;
        _jobCard.isVisible = NO;
        [self addSubview:_jobCard];
    }
}

- (void)buildUserIconBtn
{
    if(!_userIconBtn)
    {
        _userIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _userIconBtn.frame = CGRectMake(userIconBtnMargin, screenRect.size.height - (userIconWidth + userIconBtnMargin), userIconWidth, userIconHeight);
        [_userIconBtn setImage:[UIImage imageNamed:@"0.jpg"] forState:UIControlStateNormal];
        _userIconBtn.layer.cornerRadius = userIconWidth * 0.5;
        _userIconBtn.clipsToBounds = YES;
        _userIconBtn.hidden = YES;
        [_userIconBtn addTarget:self action:@selector(tapedUserIconBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_userIconBtn];
    }
}

#pragma mark - life

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.mapView = [[GKMapView alloc] initWithFrame:self.bounds];
        self.mapView.showScale = NO;
        self.mapView.showsCompass = NO;
        self.mapView.delegate = self;
        [self addSubview:self.mapView];
        
        // 设置地图中心
        [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(39.920269,116.390533)];
        // 设置缩放大小
        [self.mapView setZoomLevel:10];
        
        
        // 设置标注
        QPointAnnotation *combineAnnotation = [[QPointAnnotation alloc] init];
        [combineAnnotation setCoordinate:CLLocationCoordinate2DMake(39.987161,116.527621)];
        
        QPointAnnotation *normalAnnotation = [[QPointAnnotation alloc] init];
        [normalAnnotation setCoordinate:CLLocationCoordinate2DMake(39.867161,116.327621)];
        
        GKUserIconViewAnnotation *iconAnnotation = [[GKUserIconViewAnnotation alloc] init];
        [iconAnnotation setCoordinate:CLLocationCoordinate2DMake(39.980161,116.227621)];
        self.userCircleCoordinate = iconAnnotation.coordinate;
        
        //添加标注
        
        [self.annotations addObject:iconAnnotation];
        [self.annotations addObject:combineAnnotation];
        [self.annotations addObject:normalAnnotation];
        
        [self.mapView addAnnotations:self.annotations];
        
        [self buildJobCardView];
        [self buildUserIconBtn];
        
    }
    return self;
}


#pragma mark - QMapViewDelegate
- (QAnnotationView *)mapView:(QMapView *)mapView viewForAnnotation:(id<QAnnotation>)annotation
{
    static NSString *customReuseIndentifier = @"combineReuseIdentifieer";
    static NSString *normalReuseIndentifier = @"normalReuseIdentifieer";
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
        if ([annotation isEqual:[_annotations objectAtIndex:1]]) {
            GKCustomAnnotationView *annotationView = (GKCustomAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndentifier];
            if (annotationView == nil) {
                annotationView = [[GKCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndentifier];
                annotationView.delegate = self;
                annotationView.type = AnnotationViewTypeCombine;
                
                return annotationView;
            }
        }
        
        if ([annotation isEqual:[_annotations objectAtIndex:2]]) {
            GKCustomAnnotationView *annotationView = (GKCustomAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:normalReuseIndentifier];
            if (annotationView == nil) {
                annotationView = [[GKCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:normalReuseIndentifier];
                annotationView.delegate = self;
                annotationView.type = AnnotationViewTypeNormal;
                
                return annotationView;
            }
        }
    }
    
    return nil;
}

//<QMapViewDelegate >中的定位回调函数
- (void)mapView:(QMapView *)mapView didUpdateUserLocation:(QUserLocation *)userLocation {
    NSLog(@"latitude:%f, longitude:%f", userLocation.location.latitude, userLocation.location.longitude);
    
    _userCircleCoordinate = userLocation.location;
}


- (void)mapView:(QMapView *)mapView didSelectAnnotationView:(QAnnotationView *)view
{
    
}

- (void)mapView:(QMapView *)mapView didDeselectAnnotationView:(QAnnotationView *)view
{
    
}

- (void)mapRegionChanged:(QMapView*)mapView
{
    QMapRect mapRect = [self.mapView visibleMapRect];
    
    if(QMapRectContainsPoint(mapRect, QMapPointForCoordinate(_userCircleCoordinate)))
    {
        NSLog(@"屏幕内");
        _userIconBtn.hidden = YES;
    }else
    {
        NSLog(@"屏幕外");
        _userIconBtn.hidden = NO;
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

// 点击标注，移动到地图中心
- (void)moveAnnotationToMapCenter:(id<QAnnotation>)nnotation
{
    [self.mapView setCenterCoordinate:nnotation.coordinate animated:YES];
}

#pragma mark - private

// 点击左下用户头像
- (void)tapedUserIconBtn:(id)sender
{
    // 地图移动到以用户头像为中心的位置
    [self.mapView setCenterCoordinate:_userCircleCoordinate animated:YES];
}

- (void)addCardView
{
    if(!self.jobCard.isVisible)
    {
        self.jobCard.hidden = NO;
        [UIView animateWithDuration:1.0 animations:^{
            
            self.jobCard.transform = CGAffineTransformTranslate(self.jobCard.transform, 0, -(jobCardHeight + tabbarTopMargin + tabbarHeight));
            
        } completion:^(BOOL finished) {
            self.jobCard.isVisible = !self.jobCard.isVisible;
        }];
    }
}

- (void)removewCardView
{
    if(self.jobCard.isVisible)
    {
        [UIView animateWithDuration:1.0 animations:^
         {
             if(self.jobCard.isVisible)
             {
                 self.jobCard.transform = CGAffineTransformTranslate(self.jobCard.transform, 0, jobCardHeight + tabbarTopMargin + tabbarHeight);
             }
             
         } completion:^(BOOL finished){
             
             self.jobCard.isVisible = !self.jobCard.isVisible;
             self.jobCard.hidden = YES;
         }];
    }
}

@end
