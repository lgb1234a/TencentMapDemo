//
//  CustomAnnotationView.h
//  TencentMapDemo
//
//  Created by chenyn on 16/7/18.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import "QAnnotationView.h"

@protocol GKCustomAnnotationViewDelegate <NSObject>

- (void)iconViewClicked;


- (void)shouldPresentJobCardView:(BOOL)shouldPresent;

@end

@interface GKCustomAnnotationView : QAnnotationView

@property (nonatomic, assign) id<GKCustomAnnotationViewDelegate> delegate;

- (void)resetUI;

@end
