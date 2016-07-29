//
//  GKMapViewSingleTon.h
//  RNCandidateProj
//
//  Created by chenyn on 16/7/28.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>

@interface GKMapViewSingleTon : NSObject

/**
 *  记录用户所在坐标
 */
@property (nonatomic) CLLocationCoordinate2D userCoordinate;


+ (GKMapViewSingleTon *)sharedInstance;

@end
