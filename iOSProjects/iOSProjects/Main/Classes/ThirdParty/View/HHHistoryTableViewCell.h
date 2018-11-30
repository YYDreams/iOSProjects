//
//  HHHistoryTableViewCell.h
//  iOSProjects
//
//  Created by funtSui on 2018/11/30.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSCHistoryModel.h"
@interface HHHistoryTableViewCell : UITableViewCell


- (void)setLotteryHistoryTableType:(LotteryHistoryTableType)type model:(SSCHistoryModel *)model;

@end
