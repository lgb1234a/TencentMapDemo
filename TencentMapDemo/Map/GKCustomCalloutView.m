//
//  CustomCalloutView.m
//  TencentMapDemo
//
//  Created by chenyn on 16/7/18.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import "GKCustomCalloutView.h"

@interface GKCustomCalloutView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelSubtitle;
@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation GKCustomCalloutView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#define arrowHeight 10

#define portraitMargin 5
#define portraitWidth 50
#define portraitHeight 70

#define titleWidth 120
#define titleHeight 20

#define btnWidth 50
#define btnHeight 30

- (void)drawRect:(CGRect)rect {
    [self drawInContext:UIGraphicsGetCurrentContext()];
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

- (void)drawInContext:(CGContextRef) context {
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    [self getDarwPath:context];
    CGContextFillPath(context);
}

- (void)getDarwPath:(CGContextRef) context {
    CGRect rect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rect),
    midx = CGRectGetMidX(rect),
    maxx = CGRectGetMaxX(rect);
    CGFloat miny = CGRectGetMinY(rect),
    maxy = CGRectGetMaxY(rect) - arrowHeight;
    //绘制三角形
    CGContextMoveToPoint(context, midx + arrowHeight, maxy);
    CGContextAddLineToPoint(context, midx, maxy + arrowHeight);
    CGContextAddLineToPoint(context, midx - arrowHeight, maxy);
    //绘制圆角矩形
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, miny, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxy, radius);
    CGContextAddArcToPoint(context, maxx, maxy, minx, maxy, radius);
    
    CGContextClosePath(context);
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initSubView];
    }
    return self;
}

- (void)initSubView {
    
    // 加一层放射圆的View
    _backgroundView = [[UIView alloc]
                       initWithFrame:CGRectMake(portraitMargin,
                                                portraitMargin,
                                                portraitWidth + 30,
                                                portraitHeight + 30)];
    _backgroundView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.39];
    [self addSubview:_backgroundView];
    
    _imageView = [[UIImageView alloc]
                  initWithFrame:CGRectMake(portraitMargin,
                                           portraitMargin,
                                           portraitWidth,
                                           portraitHeight)];
    [self addSubview:_imageView];
    
    _stackView = [[UIStackView alloc]
                  initWithFrame:CGRectMake(portraitMargin *2 + portraitWidth,
                                           portraitMargin,
                                           titleWidth + portraitMargin * 2,
                                           portraitHeight + portraitMargin)];
    _stackView.axis = UILayoutConstraintAxisVertical;
    _stackView.alignment = UIStackViewAlignmentLeading;
    [self addSubview:_stackView];
    //添加title
    _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,
    0,
                                                            titleWidth,
                                                            titleHeight)];
    [_stackView addArrangedSubview:_labelTitle];
    //添加subtitle
    _labelSubtitle = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                               0,
                                                               titleWidth,
                                                               titleHeight)];
    [_stackView addArrangedSubview:_labelSubtitle];
    //添加button
    _btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _btn.frame = CGRectMake(0, 0, btnWidth, btnHeight);
    [_stackView addArrangedSubview:_btn];
}

-(void)setTitle:(NSString *)title {
    _labelTitle.text = title;
}

-(void)setSubtitle:(NSString *)subtitle {
    _labelSubtitle.text = subtitle;
}

-(void)setImage:(UIImage *)image {
    _imageView.image = image;
}

-(void)setBtnTitle:(NSString *)text forState:(UIControlState)state {
    if (text == nil) {
        return;
    }
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (text.length == 0) {
        return;
    }
    [_btn setTitle:text forState:state];
}

-(void)btnAddTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    if (_btn != nil) {
        [_btn addTarget:target action:action forControlEvents:controlEvents];
    }
}

@end
