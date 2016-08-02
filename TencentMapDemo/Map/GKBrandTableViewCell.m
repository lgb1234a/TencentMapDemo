//
//  GKBrandTableViewCell.m
//  TencentMapDemo
//
//  Created by chenyn on 16/8/2.
//  Copyright © 2016年 chenyn. All rights reserved.
//

#import "GKBrandTableViewCell.h"
#import "GKBrandCollectionViewCell.h"
#import "GKBrandCollectionView.h"

@interface GKBrandTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@property (weak, nonatomic) IBOutlet UICollectionView *brandCollectionView;


@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation GKBrandTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    /**********  配置flowLayout  ************/
    
    
    self.brandCollectionView.collectionViewLayout = flowLayout;
    
    [self.brandCollectionView registerClass:[GKBrandCollectionView class] forCellWithReuseIdentifier:@"brandCollectionView"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - collectionViewDelegate & dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GKBrandCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"brandCollectionView" forIndexPath:indexPath];
    
    return cell;
}

@end
