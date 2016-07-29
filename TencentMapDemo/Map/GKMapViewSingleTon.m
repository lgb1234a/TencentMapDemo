//
//  GKMapViewSingleTon.m
//  RNCandidateProj
//
//  Created by chenyn on 16/7/28.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "GKMapViewSingleTon.h"

@implementation GKMapViewSingleTon

+ (GKMapViewSingleTon *)sharedInstance
{
  static GKMapViewSingleTon *sharedInstance;
  static dispatch_once_t onceToken;
  
  dispatch_once(&onceToken, ^{
    sharedInstance = [[GKMapViewSingleTon alloc] init];
  });
  
  return sharedInstance;
}



@end
