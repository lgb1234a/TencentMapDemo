//
//  GKBrandCollectionViewCell.m
//  TencentMapDemo
//
//  Created by chenyn on 16/8/2.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import "GKBrandCollectionViewCell.h"

@interface GKBrandCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *brandImg;

@property (weak, nonatomic) IBOutlet UIImageView *selectedImg;

@end


@implementation GKBrandCollectionViewCell


- (void)setIsSelectedCollectionViewCell:(BOOL)isSelectedCollectionViewCell
{
    _isSelectedCollectionViewCell = isSelectedCollectionViewCell;
    
    if(isSelectedCollectionViewCell)
    {
        _selectedImg.hidden = NO;
    }else
    {
        _selectedImg.hidden = YES;
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
