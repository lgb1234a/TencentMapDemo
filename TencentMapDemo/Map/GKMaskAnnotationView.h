//
//  GKMaskAnnotationView.h
//  TencentMapDemo
//
//  Created by chenyn on 16/8/3.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKMaskAnnotationView : UIView


@property (nonatomic, strong) NSMutableArray *btnArray;

/**
 *  是否展开聚合岗位详情
 *
 *  @param needCallout YES，展开；NO，隐藏
 */
- (void)calloutSubViews:(BOOL)needCallout;

/**
 *  隐藏聚合岗位详情
 */
- (void)hideSubViews;

/**
 *  动态展开或隐藏聚合岗位
 *
 *  @param isHide          YES，展开；NO，隐藏
 *  @param completionBlock 动画完成之后的回调
 */
- (void)addHideOrCalloutAnimation:(BOOL)isHide completion:(dispatch_block_t)completionBlock;

@end
