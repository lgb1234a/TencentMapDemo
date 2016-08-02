//
//  GKCombineAnnotationView.h
//  TencentMapDemo
//
//  Created by chenyn on 16/8/2.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKCombineAnnotationView : UIView


@property (weak, nonatomic) IBOutlet UIButton *iconBtn;

@property (weak, nonatomic) IBOutlet UIButton *btn_1;
@property (weak, nonatomic) IBOutlet UIButton *btn_2;
@property (weak, nonatomic) IBOutlet UIButton *btn_3;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingBetBtn_1AndScroll;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingBetBtn_2AndScroll;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingBetBtn_3AndScroll;

@end
