//
//  ViewController.m
//  TencentMapDemo
//
//  Created by chenyn on 16/7/18.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import "ViewController.h"
#import "QMapKit.h"
#import "GKCustomAnnotationView.h"
#import "GKUserIconView.h"
#import "GKMainMapView.h"

@interface ViewController () <QMapViewDelegate, GKCustomAnnotationViewDelegate>

@property (nonatomic, strong) QMapView *mapView;

@property (nonatomic, strong) GKMainMapView *mainMapView;

@property (nonatomic, strong) NSMutableArray *annotations;

@end

@implementation ViewController

- (NSMutableArray *)annotations
{
    if(!_annotations)
    {
        self.annotations = [NSMutableArray array];
    }
    return _annotations;
}


- (void)setupMapView
{
    
    self.mainMapView = [[GKMainMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mainMapView];
    
    
//    self.mapView = [[QMapView alloc] initWithFrame:self.view.bounds];
//    self.mapView.delegate = self;
//    [self.view addSubview:self.mapView];
//    
//    //设置底图种类为卫星图
////    [self.mapView setMapType:QMapTypeSatellite];
//    
//    //设置中心点坐标为北京
//    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(39.920269,116.390533)];
//    //缩放级别设置为10时才开始显示路况
//    [self.mapView setZoomLevel:10];
//    //显示路况
//    [self.mapView setShowTraffic:YES];
//    
//    //开启定位
//    [self.mapView setShowsUserLocation:YES];
//    
//    
//    //设置标注
//    QPointAnnotation *annotation = [[QPointAnnotation alloc] init];
//    [annotation setTitle:@"中国技术交易大厦"];
//    [annotation setSubtitle:@"北京市海淀区彩和坊路北四环西路66号"];
//    [annotation setCoordinate:CLLocationCoordinate2DMake(39.987161,116.427621)];
//    
//    GKUserIconView *userIconView = [[GKUserIconView alloc] init];
//    [userIconView setCoordinate:CLLocationCoordinate2DMake(39.982121,116.250621)];
//    
//    //添加标注
//    [self.annotations addObject:annotation];
//    [self.annotations addObject:userIconView];
//    
//    [self.mapView addAnnotations:self.annotations];
}

//<QMapViewDelegate >中的定位回调函数
- (void)mapView:(QMapView *)mapView didUpdateUserLocation:(QUserLocation *)userLocation {
    NSLog(@"latitude:%f, longitude:%f", userLocation.location.latitude, userLocation.location.longitude);
}


- (QAnnotationView *)mapView:(QMapView *)mapView
           viewForAnnotation:(id<QAnnotation>)annotation
{
    static NSString *customReuseIndentifier = @"custReuseIdentifieer";
    static NSString *userIconReuseIdentifier = @"userIcon";
    
    // 用户头像
    if ([annotation isKindOfClass:[GKUserIconView class]]) {
        
        GKCustomAnnotationView *annotationView = (GKCustomAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:userIconReuseIdentifier];
        
        
        if(!annotationView)
        {
            annotationView = [[GKCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:userIconReuseIdentifier];
            annotationView.delegate = self;
            annotationView.canShowCallout = YES;
            
            [annotationView addCalloutBtnTarget:self
                                         action:@selector(iconViewClicked)
                               forControlEvents:UIControlEventTouchUpInside];
            
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
                annotationView.centerOffset = CGPointMake(image.size.width / 2, - image.size.height / 2);
                //自定义的callout中的图标
//                UIImage *image1 = [UIImage imageWithContentsOfFile:path];
//                [annotationView setCalloutImage:image];
//                [annotationView setCalloutBtnTitle:@"到这里去"
//                                          forState:UIControlStateNormal];
//                [annotationView addCalloutBtnTarget:self
//                                             action:@selector(calloutButtonAction)
//                                   forControlEvents:UIControlEventTouchUpInside];
                return annotationView;
            }
        }
    }

    return nil;
}




- (void)iconViewClicked
{
    // 点击头像
    NSLog(@"  hiahia ~ ~");
}

- (void)selectAnnotation:(id < QAnnotation >)annotation animated:(BOOL)animated
{
    
}

- (void)calloutButtonAction
{
    NSLog(@" didi ~ ~");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupMapView];
//    [self buildScrollFilter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
