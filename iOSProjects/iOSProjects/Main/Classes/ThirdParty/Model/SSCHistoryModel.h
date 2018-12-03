//
//  SSCHistoryModel.h
//  iOSProjects
//
//  Created by funtSui on 2018/11/30.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "BaseModel.h"

@interface SSCHistoryModel : BaseModel

@property (nonatomic, copy) NSString *pid;
@property (nonatomic,strong)NSString *lottery_name;//彩票名称
@property (nonatomic,strong)NSString *period_code;//开奖结果
@property (nonatomic,strong)NSString *lottery_number;//期数
@property (nonatomic,strong)NSString *period_result;//和值
@property (nonatomic,copy)  NSString *official_time;//开奖时间
@property (nonatomic,copy)  NSString *sx;//生肖
@property (nonatomic,assign)BOOL hasBall;//是否开奖了
@end

