//
//  GKUserIconView.m
//  RNCandidateProj
//
//  Created by chenyn on 16/7/28.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "GKUserIconView.h"
#import "GKCircleView.h"

@interface GKUserIconView ()

@property (nonatomic, strong) GKCircleView *circleView;

@property (nonatomic, strong) UIButton *iconBtn;

@end


#define circleViewRadius 80
#define selfBounds self.bounds
#define iconBtnWidth 60
#define iconBtnHeight 60

@implementation GKUserIconView


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return NO;
}

// 点击大头针
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *result = [super hitTest:point withEvent:event];
    
    CGPoint shopViewPointButton = [_iconBtn convertPoint:point fromView:self];
    
    if ([_iconBtn pointInside:shopViewPointButton withEvent:event]) {
        return _iconBtn;
    }
    
    return result;
}

- (id)initWithAnnotation:(id<QAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        self.image = nil;
        self.backgroundColor = [UIColor clearColor];
        
        self.circleView = [[GKCircleView alloc] initWithFrame:CGRectMake(selfBounds.origin.x, selfBounds.origin.y, circleViewRadius, circleViewRadius)];
        self.circleView.center = CGPointMake(CGRectGetMidX(selfBounds), CGRectGetMinY(selfBounds));
        
        [self addSubview:self.circleView];
        
        self.iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.iconBtn.frame = CGRectMake(selfBounds.origin.x, selfBounds.origin.y, iconBtnWidth, iconBtnHeight);
        [self.iconBtn setImage:[UIImage imageNamed:@"0.jpg"] forState:UIControlStateNormal];
        self.iconBtn.layer.cornerRadius = iconBtnWidth * 0.5;
        self.iconBtn.clipsToBounds = YES;
        self.iconBtn.center = self.circleView.center;
        
        [self addSubview:self.iconBtn];
        
    }
    return self;
}



@end
