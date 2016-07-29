//
//  GKJobCell.m
//  RNCandidateProj
//
//  Created by chenyn on 16/7/29.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "GKJobCell.h"

@interface GKJobCell ()

@property (weak, nonatomic) IBOutlet UILabel *GKJobNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *GKSalaryTypeBtn;
@property (weak, nonatomic) IBOutlet UILabel *GKSalaryLabel;

@end

@implementation GKJobCell

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
  
  [self setupSubProperty];
  
}


#pragma mark - private

- (void)setupSubProperty
{
  
  _GKSalaryTypeBtn.layer.cornerRadius = 10.5;
    _GKSalaryTypeBtn.userInteractionEnabled = NO;
  
  self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  
  UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
  selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.9302 green:0.737 blue:0.061 alpha:0.65];
  self.selectedBackgroundView = selectedBackgroundView;
}

@end
