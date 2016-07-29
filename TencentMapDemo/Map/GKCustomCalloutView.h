//
//  CustomCalloutView.h
//  TencentMapDemo
//
//  Created by chenyn on 16/7/18.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKCustomCalloutView : UIView

//设置气泡title
-(void)setTitle:(NSString *)title;
//设置气泡subtitle
-(void)setSubtitle:(NSString *)subtitle;
//设置气泡显示的图片
-(void)setImage:(UIImage *)image;
//设置气泡button样式
-(void)setBtnTitle:(NSString *)text forState:(UIControlState)state;
//设置气泡button点击回调
-(void)btnAddTarget:(id)target
             action:(SEL)action
   forControlEvents:(UIControlEvents)evnets;

@end
