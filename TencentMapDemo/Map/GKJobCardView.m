//
//  GKJobCardView.m
//  RNCandidateProj
//
//  Created by chenyn on 16/7/28.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "GKJobCardView.h"
#import "GKJobCell.h"

@interface GKJobCardView () <UITableViewDelegate, UITableViewDataSource>



@property (weak, nonatomic) IBOutlet UITableView *GKJobTableView;
@property (weak, nonatomic) IBOutlet UIView *GKCardBackgroundView;

@property (weak, nonatomic) IBOutlet UIImageView *GKImgViewFirst;
@property (weak, nonatomic) IBOutlet UIImageView *GKImgViewSecond;
@property (weak, nonatomic) IBOutlet UIImageView *GKImgViewThird;
@property (weak, nonatomic) IBOutlet UIImageView *GKImgViewForth;

@end

@implementation GKJobCardView

#pragma mark - life
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.GKJobTableView.delegate = self;
    self.GKJobTableView.dataSource = self;
    
    [self.GKJobTableView registerNib:[UINib nibWithNibName:@"GKJobCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.GKCardBackgroundView.layer.cornerRadius = 5.0;
}


#pragma mark - UITableView dataSource & delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (GKJobCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GKJobCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if(!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GKJobCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

@end
