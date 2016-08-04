//
//  GKSingleAnnotationView.m
//  TencentMapDemo
//
//  Created by chenyn on 16/8/4.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import "GKSingleAnnotationView.h"

@implementation GKSingleAnnotationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)awakeFromNib
{
    self.annotationBtn.layer.cornerRadius = self.annotationBtn.bounds.size.height * 0.5;
    self.annotationBtn.clipsToBounds = YES;
}


@end
