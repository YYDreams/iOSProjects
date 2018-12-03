//
//  NSUserDefaults+SSC.m
//  iOSProjects
//
//  Created by funtSui on 2018/12/3.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "NSUserDefaults+SSC.h"

@implementation NSUserDefaults (SSC)

+ (void)saveValue: (NSString *)value forKey:(NSString *)key{
 
    if ([value isKindOfClass:[NSNull class]] && value ==nil) {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }else{
        
        [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
}


+ (NSString *)valueForKey:(NSString *)key{
    
    return [[NSUserDefaults standardUserDefaults]objectForKey:key];
    
    
}

//玩法（0:标准 1: 快捷）
+ (void)savePlayType:(NSString *)value byLotteryId:(NSString *)lotteryId{
 
    [self saveValue:value forKey:[NSString stringWithFormat:@"playType_%@",lotteryId]];
     
}
+ (NSString *)playTypeByLotteryId:(NSString *)lotteryId{
    
    return [self valueForKey:[NSString stringWithFormat:@"playType_%@",lotteryId]];
    
}
//玩法id
+ (void)sscSavePlayId:(NSString *)value byLotteryId:(NSString *)lotteryId{
    NSString *key = [NSString stringWithFormat:@"playId_%@",lotteryId];
    [self saveValue:value forKey:key];
}
+ (NSString *)sscPlayIdByLotteryId:(NSString *)lotteryId;{
    NSString *key = [NSString stringWithFormat:@"playId_%@",lotteryId];
    return [self valueForKey:key];
}

//玩法细则
+ (void)sscSavePlaySonId:(NSString *)value byLotteryId:(NSString *)lotteryId{
    NSString *key = [NSString stringWithFormat:@"playSonId_%@",lotteryId];
    [self saveValue:value forKey:key];
}
+ (NSString *)sscPlaySonIdByLotteryId:(NSString *)lotteryId;{
    NSString *key = [NSString stringWithFormat:@"playSonId_%@",lotteryId];
    return [self valueForKey:key];
}

@end
