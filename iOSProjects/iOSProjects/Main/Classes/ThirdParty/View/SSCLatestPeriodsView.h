//
//  SSCLatestPeriodsView.h
//  iOSProjects
//
//  Created by funtSui on 2018/11/30.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SSCHistoryModel.h"

typedef enum : NSUInteger {
    SSCLotteryType28 = 1,//幸运28类
    SSCLotteryTypeK3 = 5,
    SSCLotteryTypeSSC = 10,
    SSCLotteryTypeSC = 39,
    SSCLotteryTypeSYXW = 24,
    SSCLotteryTypeMarkSix = 51,//六合彩类
    SSCLotteryTypeOther,
} SSCLotteryType;

@interface SSCLatestPeriodsView : UIView


@property(nonatomic,strong)SSCHistoryModel *model;

@end
