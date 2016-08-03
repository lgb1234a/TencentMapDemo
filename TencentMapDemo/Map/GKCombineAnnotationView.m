//
//  GKCombineAnnotationView.m
//  TencentMapDemo
//
//  Created by chenyn on 16/8/2.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import "GKCombineAnnotationView.h"

@interface GKCombineAnnotationView ()



@end

@implementation GKCombineAnnotationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)awakeFromNib
{
    self.iconBtn.layer.cornerRadius = 25.0;
    self.iconBtn.clipsToBounds = YES;
    
    self.btn_1.layer.cornerRadius = 25.0;
    self.btn_1.clipsToBounds = YES;
    
    self.btn_2.layer.cornerRadius = 25.0;
    self.btn_2.clipsToBounds = YES;
    
    self.btn_3.layer.cornerRadius = 25.0;
    self.btn_3.clipsToBounds = YES;
    
    
    self.pageControl.transform = CGAffineTransformMakeScale(0.5, 0.5);
    
//    [_btn_1 addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_btn_2 addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [_btn_3 addTarget:self action:@selector(didclickBtn:) forControlEvents:UIControlEventTouchUpInside];
}

@end
