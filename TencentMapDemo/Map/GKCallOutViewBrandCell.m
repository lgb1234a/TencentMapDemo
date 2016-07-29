//
//  GKCallOutViewBrandCell.m
//  RNCandidateProj
//
//  Created by chenyn on 16/7/29.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "GKCallOutViewBrandCell.h"

@interface GKCallOutViewBrandCell ()

@property (weak, nonatomic) IBOutlet UIButton *GKCallOutBrandCell;

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
    
    [_GKCallOutBrandCell addTarget:self action:@selector(didSelectedBrandCell) forControlEvents:UIControlEventTouchUpInside];
    
    _GKCallOutBrandCell.layer.cornerRadius = 15.0;
}

- (void)didSelectedBrandCell
{
    NSLog(@"Taped cell : %ld", _cellId);
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(GKCallOutViewBrandCell:DidSelectedBrandCellWithCellId:)])
    {
        __weak typeof(self) wself = self;
        [self.delegate GKCallOutViewBrandCell:wself DidSelectedBrandCellWithCellId:wself.cellId];
    }
}

@end
