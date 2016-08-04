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
#import "GKMaskAnnotationView.h"
#import "GKCustomAnnotation.h"

@interface GKMainMapView () <QMapViewDelegate, GKCustomAnnotationViewDelegate>

// 地图
@property (nonatomic, strong) GKMapView *mapView;

// 所有的标注
@property (nonatomic, strong) NSMutableArray *annotations;

// 岗位视图
@property (nonatomic, strong) GKJobCardView *jobCard;

// 用户头像的中心坐标
@property (nonatomic, assign) CLLocationCoordinate2D userCircleCoordinate;

// 用户头像按钮
@property (nonatomic, strong) UIButton *userIconBtn;

// 聚合岗位详情视图
@property (nonatomic, strong) GKMaskAnnotationView *maskAnnotationView;


@end


#define screenRect [UIScreen mainScreen].bounds
#define  jobCardMargin  10
#define  jobCardHeight  280
#define userIconBtnMargin 10
#define userIconWidth    60
#define userIconHeight   60
#define tabbarHeight     50
#define tabbarTopMargin  5
#define annotationViewWidth 60
#define annotationViewHeight 65
#define cardViewAnimateDur 1.0

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
        
        GKUserIconViewAnnotation *iconAnnotation = [[GKUserIconViewAnnotation alloc] init];
        [iconAnnotation setCoordinate:CLLocationCoordinate2DMake(39.980161,116.227621)];
        self.userCircleCoordinate = iconAnnotation.coordinate;
        
        GKCustomAnnotation *combineAnnotation = [[GKCustomAnnotation alloc] init];
        [combineAnnotation setCoordinate:CLLocationCoordinate2DMake(39.987161,116.427621)];
        
        GKCustomAnnotation *normalAnnotation = [[GKCustomAnnotation alloc] init];
        [normalAnnotation setCoordinate:CLLocationCoordinate2DMake(39.867161,116.327621)];
        
        GKCustomAnnotation *normalAnnotation1 = [[GKCustomAnnotation alloc] init];
        [normalAnnotation1 setCoordinate:CLLocationCoordinate2DMake(39.80000, 116.360000)];
        
        GKCustomAnnotation *normalAnnotation2 = [[GKCustomAnnotation alloc] init];
        [normalAnnotation2 setCoordinate:CLLocationCoordinate2DMake(39.70000, 116.370000)];
        
        GKCustomAnnotation *normalAnnotation3 = [[GKCustomAnnotation alloc] init];
        [normalAnnotation3 setCoordinate:CLLocationCoordinate2DMake(39.83000, 116.500000)];
        //添加标注
        
        [self.annotations addObject:iconAnnotation];
        [self.annotations addObject:combineAnnotation];
        [self.annotations addObject:normalAnnotation];
        [self.annotations addObject:normalAnnotation1];
        [self.annotations addObject:normalAnnotation2];
        [self.annotations addObject:normalAnnotation3];
        
        [self.mapView addAnnotations:self.annotations];
        
        [self buildJobCardView];
        [self buildUserIconBtn];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didTapedCalloutViewCell:) name:@"didTapedCalloutViewCell" object:nil];
    }
    return self;
}

- (void)didTapedCalloutViewCell:(NSNotification *)notification
{
    NSLog(@"taped cell with id: %@", notification.userInfo[@"userInfo"]);
    
    [self shouldPresentJobCardView:YES];
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
    
    if ([annotation isKindOfClass:[GKCustomAnnotation class]]) {
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
        
        GKCustomAnnotationView *annotationView = (GKCustomAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:normalReuseIndentifier];
        if (annotationView == nil) {
            annotationView = [[GKCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:normalReuseIndentifier];
            annotationView.delegate = self;
            annotationView.type = AnnotationViewTypeNormal;
            
            return annotationView;
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
- (void)moveAnnotationToMapCenter:(id<QAnnotation>)annotation
{
//    CGPoint newCenterPoint = CGPointMake(CGRectGetMinX(screenRect), CGRectGetMidY(screenRect) + (jobCardHeight));
//    CLLocationCoordinate2D newCenterCoordinate = [self.mapView convertPoint:newCenterPoint toCoordinateFromView:self.mapView];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(annotation.coordinate.latitude - 0.2, annotation.coordinate.longitude);
    [self.mapView setCenterCoordinate:coordinate animated:YES];
}

- (void)addMaskAnnotationView:(id<QAnnotation>)annotation withAnnotationRect:(CGRect)annotationRect
{
    // 地图坐标转换为屏幕坐标系坐标
    CGPoint annotationPoint = [self.mapView convertCoordinate:annotation.coordinate toPointToView:self];
    
    UIButton *maskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    maskBtn.backgroundColor = [UIColor clearColor];
    maskBtn.frame = self.bounds;
    [maskBtn addTarget:self action:@selector(didTapedMaskBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _maskAnnotationView = [[[NSBundle mainBundle] loadNibNamed:@"GKMaskAnnotationView" owner:nil options:nil] firstObject];
    _maskAnnotationView.center = annotationPoint;
    
    
    [_maskAnnotationView addHideOrCalloutAnimation:NO completion:nil];
    
    [self insertSubview:_maskAnnotationView belowSubview:self.jobCard];
    [self insertSubview:maskBtn belowSubview:_maskAnnotationView];
    
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
    UIButton *maskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    maskBtn.backgroundColor = [UIColor clearColor];
    maskBtn.frame = self.bounds;
    [maskBtn addTarget:self action:@selector(tapedToHideCardView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self insertSubview:maskBtn belowSubview:self.jobCard];
    
    if([self.subviews containsObject:_maskAnnotationView])
    {
        [maskBtn removeFromSuperview];
        [self insertSubview:maskBtn belowSubview:_maskAnnotationView];
    }
    
    
    if(!self.jobCard.isVisible)
    {
        self.jobCard.hidden = NO;
        [UIView animateWithDuration:cardViewAnimateDur animations:^{
            
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
        [UIView animateWithDuration:cardViewAnimateDur animations:^
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


- (void)didTapedMaskBtn:(id)sender
{
    // 点击了遮罩
    
    UIButton *btn = (UIButton *)sender;
    [btn removeFromSuperview];
    
    __weak typeof(_maskAnnotationView) weakView = _maskAnnotationView;
    [_maskAnnotationView addHideOrCalloutAnimation:YES completion:^{
        [weakView removeFromSuperview];
    }];
}

- (void)tapedToHideCardView:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    [btn removeFromSuperview];
    
    [self removewCardView];
}

@end
