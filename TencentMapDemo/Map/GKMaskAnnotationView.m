//
//  GKMaskAnnotationView.m
//  TencentMapDemo
//
//  Created by chenyn on 16/8/3.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import "GKMaskAnnotationView.h"
#import "GKCallOutViewBrandCell.h"
#import <masonry.h>

@interface GKMaskAnnotationView ()

@property (nonatomic, strong) NSMutableArray *brandDataArray;


@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;



@property (nonatomic, strong) UIView *container;

@end

@implementation GKMaskAnnotationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (NSMutableArray *)brandDataArray
{
    if(!_brandDataArray)
    {
        _brandDataArray = [NSMutableArray arrayWithObjects:@1, @2, @3, @4, @5, @6, nil];
    }
    return _brandDataArray;
}

- (NSMutableArray *)btnArray
{
    if(!_btnArray)
    {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}


- (void)awakeFromNib
{
    
}

- (void)calloutSubViews:(BOOL)needCallout
{
    CGFloat cellMargin = 5.0;
    CGFloat cellWidth  = 50.0;
    CGFloat cellHeight = 50.0;
    static CGFloat selfWidth  = 5.0;
    CGFloat selfHeight = 65.0;
    
    for(int i = 0; i < self.brandDataArray.count; i++)
    {
        GKCallOutViewBrandCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"GKCallOutViewBrandCell" owner:nil options:nil] lastObject];
        cell.cellId = [self.brandDataArray[i] integerValue];
        cell.tag = i;
        
        
        [_backScrollView addSubview:cell];
        [_backScrollView sendSubviewToBack:cell];
        // 与数组中前一个btn建立约束
        [cell mas_updateConstraints:^(MASConstraintMaker *make) {
            
            if(needCallout)
            {
                make.left.mas_equalTo(_backScrollView.mas_left).with.offset(selfWidth);
                
                selfWidth = selfWidth + cellWidth + cellMargin;
            }else
            {
                make.left.mas_equalTo(_backScrollView.mas_left).with.offset(cellMargin);
                
                selfWidth = selfWidth - (cellWidth + cellMargin);
            }
            
            make.width.equalTo(@(cellWidth));
            make.height.equalTo(@(cellHeight));
            make.top.equalTo(_backScrollView).with.offset(cellMargin);
        }];
        
        _backScrollView.contentSize = CGSizeMake(selfWidth, selfHeight);
        
        if(i < 4)
        {
            self.bounds = CGRectMake(0, 0, selfWidth, selfHeight);
        }
        
        [self.btnArray addObject:cell];
        
        [self layoutIfNeeded];
    }
    
    _selfWidth = selfWidth;
    
    self.layer.cornerRadius = self.bounds.size.height * 0.5;
    self.clipsToBounds = YES;
    self.pageControl.transform = CGAffineTransformMakeScale(0.5, 0.5);
    _backScrollView.scrollEnabled = YES;
}

- (void)hideSubViews
{
    [self calloutSubViews:NO];
}

- (void)addHideOrCalloutAnimation:(BOOL)isHide completion:(dispatch_block_t)completionBlock
{
    if(isHide)
    {
        [UIView animateWithDuration:0.8 animations:^{
            [self hideSubViews];
        } completion:^(BOOL finished) {
            if(completionBlock)
            {
                completionBlock();
            }
        }];
    }else
    {
        [UIView animateWithDuration:0.8 animations:^{
            [self calloutSubViews:YES];
        } completion:^(BOOL finished) {
            
            if(completionBlock)
            {
                completionBlock();
            }
        }];
    }
}

@end
