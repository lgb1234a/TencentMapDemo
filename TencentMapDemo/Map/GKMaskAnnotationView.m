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

@interface GKMaskAnnotationView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *brandDataArray;


@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;



@property (nonatomic, strong) UIView *container;

@end

#define cellMargin 5.0
#define cellWidth  50.0
#define cellHeight 50.0
#define selfHeight 65.0

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
        _brandDataArray = [NSMutableArray arrayWithObjects:@1, @2, @3, @4, @5, @6, @7, @8, @9, nil];
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
    static CGFloat selfWidth  = 5.0;
    static CGFloat perPageWidth = 0.0;
    
    for(int i = 0; i < self.brandDataArray.count; i++)
    {
        
        if(needCallout)
        {
            GKCallOutViewBrandCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"GKCallOutViewBrandCell" owner:nil options:nil] lastObject];
            cell.cellId = [self.brandDataArray[i] integerValue];
            cell.tag = i;
            [_backScrollView addSubview:cell];
            [_backScrollView sendSubviewToBack:cell];
            
            // 与数组中前一个btn建立约束
            [cell mas_updateConstraints:^(MASConstraintMaker *make) {
                
                
                make.left.mas_equalTo(_backScrollView.mas_left).with.offset(selfWidth);
                    
                selfWidth = selfWidth + cellWidth + cellMargin;
                
                
                make.width.equalTo(@(cellWidth));
                make.height.equalTo(@(cellHeight));
                make.top.equalTo(_backScrollView).with.offset(cellMargin);
            }];
            
            
            [self.btnArray addObject:cell];
            
            if(i < 4)
            {
                self.bounds = CGRectMake(0, 0, selfWidth, selfHeight);
            }
            
            if(i == 3)
            {
                perPageWidth = selfWidth;
            }
            
            [self configSubViews];
        }else
        {
            GKCallOutViewBrandCell *cell = self.btnArray[i];
            
            [cell mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.left.mas_equalTo(_backScrollView.mas_left).with.offset(cellMargin);
                selfWidth = selfWidth - (cellWidth + cellMargin);
                make.width.equalTo(@(cellWidth));
                make.height.equalTo(@(cellHeight));
                make.top.equalTo(_backScrollView).with.offset(cellMargin);
            }];
            
            self.bounds = CGRectMake(0, 0, selfWidth, selfHeight);
        }
        
        [self layoutIfNeeded];
    }
    
    if(needCallout)
    {
        if(perPageWidth == 0.0)
        {
            _backScrollView.contentSize = CGSizeMake(selfWidth, cellHeight);
        }else
        {
            _backScrollView.contentSize = CGSizeMake(perPageWidth * ceilf(self.brandDataArray.count / 4.0), cellHeight);
        }
    }
    
    _selfWidth = selfWidth;
    
}


- (void)configSubViews
{
    self.layer.cornerRadius = self.bounds.size.height * 0.5;
    self.clipsToBounds = YES;
    self.pageControl.transform = CGAffineTransformMakeScale(0.5, 0.5);
    _backScrollView.scrollEnabled = YES;
    _backScrollView.delegate = self;
    _backScrollView.showsVerticalScrollIndicator = NO;
    _backScrollView.showsHorizontalScrollIndicator = NO;
    _backScrollView.directionalLockEnabled = YES;
    _backScrollView.pagingEnabled = YES;
    
    CGFloat numberPages = self.brandDataArray.count / 4.0;
    self.pageControl.numberOfPages = ceilf(numberPages);
    
    if(numberPages < 1.0)
    {
        self.pageControl.hidden = YES;
    }
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

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat selfWidth = self.bounds.size.width;
    
    self.pageControl.currentPage = floorf((scrollView.contentOffset.x / selfWidth) + 0.5);
    
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    CGFloat selfWidth = self.bounds.size.width;
    CGPoint originOffset = scrollView.contentOffset;
    NSInteger pageNumber = floorf((scrollView.contentOffset.x / selfWidth) + 0.5);
    
    scrollView.contentOffset = CGPointMake(originOffset.x - pageNumber * cellMargin, originOffset.y);
}



@end
