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

/**
 *  店家button之后触发的代理事件
 *
 *  @param cell   所属cell
 *  @param cellId 传递的数据
 */
- (void)GKCallOutViewBrandCell:(GKCallOutViewBrandCell *)cell DidSelectedBrandCellWithCellId:(NSInteger)cellId;

@end

@interface GKCallOutViewBrandCell : UIView

/**
 *  模拟model
 */
@property (nonatomic, assign) NSInteger cellId;

/**
 *  接收事件的button
 */
@property (weak, nonatomic) IBOutlet UIButton *callOutBrandBtn;

/**
 *  代理
 */
@property (nonatomic, assign) id<GKCallOutViewBrandCellDelegate> delegate;

@end
