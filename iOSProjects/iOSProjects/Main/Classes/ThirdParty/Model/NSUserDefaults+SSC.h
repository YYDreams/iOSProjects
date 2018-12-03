//
//  NSUserDefaults+SSC.h
//  iOSProjects
//
//  Created by funtSui on 2018/12/3.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (SSC)
//玩法（0:标准 1: 快捷）
+ (void)savePlayType:(NSString *)value byLotteryId:(NSString *)lotteryId;
+ (NSString *)playTypeByLotteryId:(NSString *)lotteryId;

//玩法id
+ (void)sscSavePlayId:(NSString *)value byLotteryId:(NSString *)lotteryId;
+ (NSString *)sscPlayIdByLotteryId:(NSString *)lotteryId;

//玩法细则
+ (void)sscSavePlaySonId:(NSString *)value byLotteryId:(NSString *)lotteryId;
+ (NSString *)sscPlaySonIdByLotteryId:(NSString *)lotteryId;

@end
