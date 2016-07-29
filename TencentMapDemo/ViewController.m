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
