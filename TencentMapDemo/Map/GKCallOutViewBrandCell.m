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

//NSString *const notiScreenTouch = @"notiScreenTouch";

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
    
//    _GKCallOutBrandCell.layer.cornerRadius = 15.0;
    
    self.backgroundColor = [UIColor clearColor];
    self.GKCallOutBrandCell.layer.cornerRadius = 20.0;
    self.GKCallOutBrandCell.clipsToBounds = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onScreenTouch:) name:@"notiScreenTouch" object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)onScreenTouch:(NSNotification *)notification
{
    UIEvent *event = [notification.userInfo objectForKey:@"data"];
    
    NSLog(@"touch screen!!!!!");
    CGPoint pt = [[[[event allTouches] allObjects] objectAtIndex:0] locationInView:self.GKCallOutBrandCell];
    NSLog(@"pt.x=%f, pt.y=%f", pt.x, pt.y);
    
    CGPoint pointInCallout = [self convertPoint:pt toView:self.GKCallOutBrandCell];
    
    BOOL inside = CGRectContainsPoint(self.GKCallOutBrandCell.bounds, pointInCallout);
    
    if(inside)
    {
        NSLog(@"%@  %ld", NSStringFromCGRect(self.frame), _cellId);
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(GKCallOutViewBrandCell:didSelectedBrandCellWithCellId:)])
        {
            __weak typeof(self) wself = self;
            [self.delegate GKCallOutViewBrandCell:wself didSelectedBrandCellWithCellId:wself.cellId];
        }
    }
}


@end
