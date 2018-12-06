//
//  SSCCacheManager.m
//  iOSProjects
//
//  Created by funtSui on 2018/12/6.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "SSCCacheManager.h"

@implementation SSCCacheManager

/**
 
 */
+ (BOOL)saveStructModel:(SSCStructModel *)model lotteryId:(NSString *)lotteryId{
//
//    NSString *path = [self getPathLotteryId:lotteryId];
//    BOOL result = [NSKeyedArchiver archiveRootObject:model toFile:path];
//    return result;
    
    return [NSKeyedArchiver archiveRootObject:model toFile:[self getPathLotteryId:lotteryId]];
    
}

/**
 
 */
+ (SSCStructModel *)getStructLotteryId:(NSString *)lotteryId{
   
    
    NSString *path = [self getPathLotteryId:lotteryId];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
     
      return  [NSKeyedUnarchiver unarchiveObjectWithFile:path];

    }
    
    return nil;
    
}

+ (NSString *)getPathLotteryId:(NSString *)lotteryId{
    
 NSString *document =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
  NSString *filePath = [document stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",lotteryId]];
    
    NSLog(@"filePath:%@",filePath);
    return filePath;
    
}
@end
