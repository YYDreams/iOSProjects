//
//  HHLotteryListModel.h
//  iOSProjects
//
//  Created by flowerflower on 2018/11/9.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "BaseModel.h"

@interface HHLotteryListModel : BaseModel

///彩票id
@property (nonatomic, strong) NSNumber * id;
@property (nonatomic , assign) NSInteger              pid;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * img;
@property (nonatomic , copy) NSString              * state;
@property (nonatomic , copy) NSString              * alias;
@property (nonatomic , copy) NSString              * code;
@property (nonatomic , copy) NSString              * open_img;

@property (nonatomic , assign) NSInteger              lottery_number;
@property (nonatomic , copy) NSString              * period_code;
@property (nonatomic , assign) NSInteger              official_time;
@end
