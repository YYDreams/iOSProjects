//
//  HHLotteryListModel.m
//  iOSProjects
//
//  Created by flowerflower on 2018/11/9.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHLotteryListModel.h"
#import <WCDB/WCDB.h>


@interface HHLotteryListModel()<WCTTableCoding>

WCDB_PROPERTY(period_code)
WCDB_PROPERTY(lottery_number)
WCDB_PROPERTY(open_img)
WCDB_PROPERTY(name)
WCDB_PROPERTY(id)


@end
@implementation HHLotteryListModel
// 使用 WCDB_IMPLEMENTATIO 宏在类文件定义绑定到数据库表的类
WCDB_IMPLEMENTATION(HHLotteryListModel)
// 使用 WCDB_SYNTHESIZE 宏在类文件定义需要绑定到数据库表的字段
WCDB_SYNTHESIZE(HHLotteryListModel, period_code)
WCDB_SYNTHESIZE(HHLotteryListModel, lottery_number)
WCDB_SYNTHESIZE(HHLotteryListModel, name)
WCDB_SYNTHESIZE(HHLotteryListModel, open_img)

WCDB_SYNTHESIZE(HHLotteryListModel, id)

// 用于定义主键
WCDB_PRIMARY(HHLotteryListModel, id)

@end

