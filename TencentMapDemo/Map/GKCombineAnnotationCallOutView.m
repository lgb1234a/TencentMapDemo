//
//  GKCombineAnnotationCallOutView.m
//  RNCandidateProj
//
//  Created by chenyn on 16/7/29.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "GKCombineAnnotationCallOutView.h"
#import "GKCallOutViewBrandCell.h"

@interface GKCombineAnnotationCallOutView () <GKCallOutViewBrandCellDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *GKCombineBrandScrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *GKPageControl;

@property (nonatomic, strong) NSMutableArray *brandDataArray;

@end


@implementation GKCombineAnnotationCallOutView

- (NSMutableArray *)brandDataArray
{
    if(!_brandDataArray)
    {
        _brandDataArray = [NSMutableArray arrayWithArray:@[@1, @2, @3, @4, @5]];
    }
    
    return _brandDataArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _GKPageControl.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
    
//    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = 22.5;
    
    static CGFloat cellMargin = 5.0;
    static CGFloat cellWidth  = 30.0;
    static CGFloat cellHeight = 30.0;
    static CGFloat selfWidth  = 5.0;
    static CGFloat selfHeight = 45.0;
    
    for(int i = 0; i < self.brandDataArray.count; i++)
    {
        GKCallOutViewBrandCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"GKCallOutViewBrandCell" owner:nil options:nil] lastObject];
        cell.cellId = [self.brandDataArray[i] integerValue];
        cell.delegate = self;
        
        cell.frame = CGRectMake(selfWidth, 0, cellWidth, cellHeight);
        selfWidth = selfWidth + cellWidth + cellMargin;
        
        _GKCombineBrandScrollView.contentSize = CGSizeMake(selfWidth, selfHeight);
        
        if(i < 4)
        {
            self.bounds = CGRectMake(0, 0, selfWidth, selfHeight);
        }
        
        [_GKCombineBrandScrollView addSubview:cell];
        
    }
}

- (void)GKCallOutViewBrandCell:(GKCallOutViewBrandCell *)cell DidSelectedBrandCellWithCellId:(NSInteger)cellId
{
    
}

@end
