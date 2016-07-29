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

@end

@interface GKCustomAnnotationView : QAnnotationView
//设置callout要显示的图片
-(void)setCalloutImage:(UIImage *)image;

//设置callout内置button的标题和状态
-(void)setCalloutBtnTitle:(NSString *)title
                 forState:(UIControlState)state;

//设置callout的button回调
-(void)addCalloutBtnTarget:(id)target
                    action:(SEL)action
          forControlEvents:(UIControlEvents)events;


@property (nonatomic, assign) id<GKCustomAnnotationViewDelegate> delegate;

@end
