//
//  CustomAnnotationView.h
//  TencentMapDemo
//
//  Created by chenyn on 16/7/18.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import "QAnnotationView.h"

typedef NS_ENUM(NSUInteger, AnnotationViewType) {
    AnnotationViewTypeNormal,   // 普通标注
    AnnotationViewTypeCombine,  // 聚合标注
};

@protocol GKCustomAnnotationViewDelegate <NSObject>

- (void)shouldPresentJobCardView:(BOOL)shouldPresent;

- (void)moveAnnotationToMapCenter:(id <QAnnotation>) nnotation;

@end

@interface GKCustomAnnotationView : QAnnotationView

@property (nonatomic, assign) AnnotationViewType type;

@property (nonatomic, assign) id<GKCustomAnnotationViewDelegate> delegate;

- (void)resetUI;

@end
