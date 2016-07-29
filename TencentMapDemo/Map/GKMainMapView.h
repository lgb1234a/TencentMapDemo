//
//  GKMainMapView.h
//  TencentMapDemo
//
//  Created by chenyn on 16/7/27.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GKMainMapViewDelegate <NSObject>



@end


@interface GKMainMapView : UIView


@property (nonatomic, assign) id<GKMainMapViewDelegate> delegate;


@end
