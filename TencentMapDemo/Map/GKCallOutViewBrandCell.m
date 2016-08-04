//
//  GKCallOutViewBrandCell.m
//  RNCandidateProj
//
//  Created by chenyn on 16/7/29.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "GKCallOutViewBrandCell.h"

@interface GKCallOutViewBrandCell ()


@end

#define scaleMaxDur 0.2
#define scaleMinDur 0.1
#define annotationViewMaxScale 1.1
#define annotationViewMinScale (10 / 11.0)

@implementation GKCallOutViewBrandCell

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 初始化UI
    [_callOutBrandBtn addTarget:self action:@selector(didSelectedBrandCell) forControlEvents:UIControlEventTouchUpInside];
    _callOutBrandBtn.layer.cornerRadius = self.bounds.size.height * 0.5;
    _callOutBrandBtn.clipsToBounds = YES;
}

// 点击按钮事件
- (void)didSelectedBrandCell
{
    NSLog(@"Taped cell : %ld", _cellId);
    
    [UIView animateWithDuration:scaleMaxDur animations:^{
        self.transform = CGAffineTransformScale(self.transform, annotationViewMaxScale, annotationViewMaxScale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:scaleMinDur animations:^{
            self.transform = CGAffineTransformScale(self.transform, annotationViewMinScale, annotationViewMinScale);
        } completion:^(BOOL finished) {
            if(self.delegate && [self.delegate respondsToSelector:@selector(GKCallOutViewBrandCell:DidSelectedBrandCellWithCellId:)])
            {
                __weak typeof(self) wself = self;
                [self.delegate GKCallOutViewBrandCell:wself DidSelectedBrandCellWithCellId:wself.cellId];
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"didTapedCalloutViewCell" object:self userInfo:@{@"userInfo" : @(_cellId)}];
        }];
    }];
}

@end
