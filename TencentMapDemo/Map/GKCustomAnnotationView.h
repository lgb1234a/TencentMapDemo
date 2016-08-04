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

/**
 *  是否弹出岗位视图
 *
 *  @param shouldPresent YES，显示  NO，隐藏
 */
- (void)shouldPresentJobCardView:(BOOL)shouldPresent;

/**
 *  移动annotation到地图中心
 *
 *  @param annotation 需要移动到地图中心的标注
 */
- (void)moveAnnotationToMapCenter:(id <QAnnotation>)annotation;

/**
 *  添加聚合岗位展开详情View
 *
 *  @param annotation     标注创建的位置信息
 *  @param annotationRect 标注所在的Rect
 */
- (void)addMaskAnnotationView:(id<QAnnotation>)annotation withAnnotationRect:(CGRect)annotationRect;

@end

@interface GKCustomAnnotationView : QAnnotationView

/**
 *  标注View的类型
 */
@property (nonatomic, assign) AnnotationViewType type;

/**
 *  标注View的代理
 */
@property (nonatomic, assign) id<GKCustomAnnotationViewDelegate> delegate;

@end
