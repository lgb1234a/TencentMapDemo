//
//  GKCallOutAnnotationView.m
//  TencentMapDemo
//
//  Created by chenyn on 16/8/3.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import "GKCallOutAnnotationView.h"
#import <Masonry.h>

@interface GKCallOutAnnotationView () <GKCallOutViewBrandCellDelegate>

@property (nonatomic, strong) NSMutableArray *brandDataArray;


@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;



@property (nonatomic, strong) UIView *container;
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

- (NSMutableArray *)btnArray
{
    if(!_btnArray)
    {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (UIButton *)homeBtn
{
    if(!_homeBtn)
    {
        _homeBtn = ((GKCallOutViewBrandCell *)[self.btnArray firstObject]).callOutBrandBtn;
    }
    
    return _homeBtn;
}


- (void)awakeFromNib
{
    
    static CGFloat cellMargin = 5.0;
    static CGFloat cellWidth  = 50.0;
    static CGFloat cellHeight = 50.0;
    static CGFloat selfWidth  = 5.0;
    static CGFloat selfHeight = 50.0;

    
    _container = [UIView new];
    _container.backgroundColor = [UIColor clearColor];
    
    [_backScrollView addSubview:_container];
    
    [_container mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_backScrollView);
        make.width.equalTo(_backScrollView);
    }];
    
    for(int i = 0; i < self.brandDataArray.count; i++)
    {
        GKCallOutViewBrandCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"GKCallOutViewBrandCell" owner:nil options:nil] lastObject];
        cell.cellId = [self.brandDataArray[i] integerValue];
        cell.delegate = self;
        cell.tag = i;
        
        [_container addSubview:cell];
        
        // 与数组中前一个btn建立约束
        
        [cell mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(_container.mas_left).with.offset(cellMargin);
            make.width.equalTo(@(cellWidth));
            make.height.equalTo(@(cellHeight));
            make.top.equalTo(_container).with.offset(cellMargin);
        }];
        
        
        selfWidth = selfWidth + cellWidth + cellMargin;
        
        if(i < 4)
        {
            self.bounds = CGRectMake(0, 0, selfWidth, selfHeight);
        }
        
        [self.btnArray addObject:cell];
        
        [self layoutIfNeeded];
    }
    
    _selfWidth = selfWidth;
}

- (void)calloutSubViews:(BOOL)needCallout
{
    CGFloat cellMargin = 5.0;
    CGFloat cellWidth  = 50.0;
    CGFloat cellHeight = 50.0;
    CGFloat selfWidth  = 5.0;
    CGFloat selfHeight = 50.0;
    
    for(int i = 0; i < self.brandDataArray.count; i++)
    {
        GKCallOutViewBrandCell *cell = self.btnArray[i];
        
        // 与数组中前一个btn建立约束
        
        [cell mas_updateConstraints:^(MASConstraintMaker *make) {
            
            if(needCallout)
            {
                
                make.left.mas_equalTo(_container.mas_left).with.offset(selfWidth);
            }else
            {
                make.left.mas_equalTo(_container.mas_left).with.offset(cellMargin);
            }
            
            make.width.equalTo(@(cellWidth));
            make.height.equalTo(@(cellHeight));
            make.top.equalTo(_container).with.offset(cellMargin);
        }];
        
        
        selfWidth = selfWidth + cellWidth + cellMargin;
        
        [self layoutIfNeeded];
    }
}

- (void)hideSubViews
{
    [self calloutSubViews:NO];
}

@end
