//
//  GKCallOutAnnotationView.h
//  TencentMapDemo
//
//  Created by chenyn on 16/8/3.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKCallOutViewBrandCell.h"

@interface GKCallOutAnnotationView : UIView

@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic, strong) UIButton *homeBtn; // 第一个

@property (nonatomic, assign) CGFloat selfWidth;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

- (void)calloutSubViews:(BOOL)needCallout;

- (void)hideSubViews;


@end
