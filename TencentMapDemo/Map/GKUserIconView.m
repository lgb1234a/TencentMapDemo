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
        
        self.circleView = [[GKCircleView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, 80, 80)];
        self.circleView.center = CGPointMake(self.bounds.origin.x + self.bounds.size.width * 0.5, self.bounds.origin.y + self.bounds.size.height * 0.5);
        
        [self addSubview:self.circleView];
        
        self.iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.iconBtn.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, 60, 60);
        [self.iconBtn setImage:[UIImage imageNamed:@"subway_station"] forState:UIControlStateNormal];
        self.iconBtn.layer.cornerRadius = 30.0;
        self.iconBtn.center = CGPointMake(self.bounds.origin.x + self.bounds.size.width * 0.5, self.bounds.origin.y + self.bounds.size.height * 0.5);
        [self.iconBtn addTarget:self action:@selector(clickedUserIcon:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.iconBtn];
        
    }
    return self;
}

// 点击用户头像
- (void)clickedUserIcon:(id)sender
{
    
}


@end
