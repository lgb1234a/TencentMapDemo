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
    
    [_callOutBrandBtn addTarget:self action:@selector(didSelectedBrandCell) forControlEvents:UIControlEventTouchUpInside];
    
    
    _callOutBrandBtn.layer.cornerRadius = self.bounds.size.height * 0.5;
    _callOutBrandBtn.clipsToBounds = YES;
}

- (void)didSelectedBrandCell
{
    NSLog(@"Taped cell : %ld", _cellId);
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(GKCallOutViewBrandCell:DidSelectedBrandCellWithCellId:)])
    {
        __weak typeof(self) wself = self;
        [self.delegate GKCallOutViewBrandCell:wself DidSelectedBrandCellWithCellId:wself.cellId];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didTapedCalloutViewCell" object:self userInfo:@{@"userInfo" : @(_cellId)}];
}

@end
