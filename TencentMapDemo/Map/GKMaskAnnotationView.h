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

@property (nonatomic, assign) CGFloat selfWidth;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

- (void)calloutSubViews:(BOOL)needCallout;

- (void)hideSubViews;

- (void)addHideOrCalloutAnimation:(BOOL)isHide completion:(dispatch_block_t)completionBlock;

@end
