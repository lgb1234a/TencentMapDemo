//
//  GKCallOutAnnotationView.m
//  TencentMapDemo
//
//  Created by chenyn on 16/8/3.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import "GKCallOutAnnotationView.h"
#import "GKCallOutViewBrandCell.h"

@interface GKCallOutAnnotationView () <GKCallOutViewBrandCellDelegate>

@property (nonatomic, strong) NSMutableArray *brandDataArray;

@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

#define btnWidth 50
#define btnHeight 50


@implementation GKCallOutAnnotationView

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


- (void)awakeFromNib
{
    
    static CGFloat cellMargin = 5.0;
    static CGFloat cellWidth  = 50.0;
    static CGFloat cellHeight = 50.0;
    static CGFloat selfWidth  = 5.0;
    static CGFloat selfHeight = 50.0;

    
    for(int i = 0; i < self.brandDataArray.count; i++)
    {
        GKCallOutViewBrandCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"GKCallOutViewBrandCell" owner:nil options:nil] lastObject];
        cell.cellId = [self.brandDataArray[i] integerValue];
        cell.delegate = self;
        
        cell.frame = CGRectMake(selfWidth, 0, cellWidth, cellHeight);
        selfWidth = selfWidth + cellWidth + cellMargin;
        
        _backScrollView.contentSize = CGSizeMake(selfWidth, selfHeight);
        
        if(i < 4)
        {
            self.bounds = CGRectMake(0, 0, selfWidth, selfHeight);
        }
        
        [_backScrollView addSubview:cell];
        
        [self layoutIfNeeded];
    }
}


@end
