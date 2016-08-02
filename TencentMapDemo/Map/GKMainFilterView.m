//
//  GKMainFilterView.m
//  TencentMapDemo
//
//  Created by chenyn on 16/8/2.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import "GKMainFilterView.h"
#import "GKBrandTableViewCell.h"
#import "GKJobTypeTableViewCell.h"

@interface GKMainFilterView () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *filterTableView;

@property (weak, nonatomic) IBOutlet UIButton *resetBtn;

@property (weak, nonatomic) IBOutlet UIButton *commitBtn;



@end

@implementation GKMainFilterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib
{
    [self.filterTableView registerNib:[UINib nibWithNibName:@"GKBrandTableViewCell" bundle:nil] forCellReuseIdentifier:@"brandTableViewCell"];
    [self.filterTableView registerNib:[UINib nibWithNibName:@"GKJobTypeTableViewCell" bundle:nil] forCellReuseIdentifier:@"GKJobTypeTableViewCell"];
}

#pragma mark - UITableViewDelegate & Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            // 品牌名称筛选
        {
            GKBrandTableViewCell *brandCell = [tableView dequeueReusableCellWithIdentifier:@"brandTableViewCell" forIndexPath:indexPath];
            
            return brandCell;
        }
            break;
        case 1:
            // 岗位类型筛选
        {
            GKJobTypeTableViewCell *jobTypeCell = [tableView dequeueReusableCellWithIdentifier:@"GKJobTypeTableViewCell" forIndexPath:indexPath];
            
            return jobTypeCell;
        }
            break;
        default:
            return nil;
            break;
    }
}


@end
