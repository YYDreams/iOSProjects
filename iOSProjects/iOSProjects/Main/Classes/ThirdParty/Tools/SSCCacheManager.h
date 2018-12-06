//
//  SSCCacheManager.h
//  iOSProjects
//
//  Created by funtSui on 2018/12/6.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSCStructModel.h"
@interface SSCCacheManager : NSObject

/**
 
 */
+ (BOOL)saveStructModel:(SSCStructModel *)model lotteryId:(NSString *)lotteryId;

/**
 
 */
+ (SSCStructModel *)getStructLotteryId:(NSString *)lotteryId;
@end
