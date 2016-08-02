//
//  GKCombineAnnotationCallOutView.m
//  RNCandidateProj
//
//  Created by chenyn on 16/7/29.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "GKCombineAnnotationCallOutView.h"
#import "GKCallOutViewBrandCell.h"

@interface GKCombineAnnotationCallOutView () <GKCallOutViewBrandCellDelegate, UIScrollViewDelegate>

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
    self.layer.cornerRadius = 27.5;
    
    static CGFloat cellMargin = 5.0;
    static CGFloat cellWidth  = 40.0;
    static CGFloat cellHeight = 40.0;
    static CGFloat selfWidth  = 5.0;
    static CGFloat selfHeight = 55.0;
    
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
    
    _GKCombineBrandScrollView.delegate = self;
    
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)onScreenMoved:(NSNotification *)notification
{
    UIEvent *event = [notification.userInfo objectForKey:@"data"];
    
    NSLog(@"move screen!!!!!");
    CGPoint pt = [[[[event allTouches] allObjects] objectAtIndex:0] locationInView:self.GKCombineBrandScrollView];
    NSLog(@"pt.x=%f, pt.y=%f", pt.x, pt.y);
    
    CGPoint pointInCallout = [self convertPoint:pt toView:self.GKCombineBrandScrollView];
    
    BOOL inside = CGRectContainsPoint(self.GKCombineBrandScrollView.bounds, pointInCallout);
    
    if(inside)
    {
        CGPoint scrollViewOrigin = self.GKCombineBrandScrollView.bounds.origin;
        CGFloat width = pointInCallout.x - scrollViewOrigin.x;
        CGFloat height = pointInCallout.y - scrollViewOrigin.y;
        self.GKCombineBrandScrollView.contentOffset = CGPointMake(pt.x - width, pt.y - height);
    }
}


// 点击大头针
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *result = [super hitTest:point withEvent:event];
    
    
    return result;
}

- (void)GKCallOutViewBrandCell:(GKCallOutViewBrandCell *)cell didSelectedBrandCellWithCellId:(NSInteger)cellId
{
    NSLog(@"clicked cell with id: %ld", cellId);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%@", NSStringFromCGPoint(self.GKCombineBrandScrollView.contentOffset));
}


@end
