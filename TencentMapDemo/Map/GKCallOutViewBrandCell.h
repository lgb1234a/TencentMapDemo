//
//  GKCallOutViewBrandCell.h
//  RNCandidateProj
//
//  Created by chenyn on 16/7/29.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GKCallOutViewBrandCell;

@protocol GKCallOutViewBrandCellDelegate <NSObject>

- (void)GKCallOutViewBrandCell:(GKCallOutViewBrandCell *)cell didSelectedBrandCellWithCellId:(NSInteger)cellId;

@end

@interface GKCallOutViewBrandCell : UIView

@property (nonatomic, assign) NSInteger cellId;

@property (nonatomic, assign) id<GKCallOutViewBrandCellDelegate> delegate;



@end
