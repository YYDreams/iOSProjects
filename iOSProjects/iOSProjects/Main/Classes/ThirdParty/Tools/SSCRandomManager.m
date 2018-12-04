//
//  SSCRandomManager.m
//  iOSProjects
//
//  Created by funtSui on 2018/12/4.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "SSCRandomManager.h"
#import "SSCBallViewModel.h"
#import "SSCBallCellModel.h"
@implementation SSCRandomManager

+(NSDictionary *)randomByRandomMethodName:(NSString *)methodName ballArray:(NSArray *)ballArray{
    NSString *fName = [NSString stringWithFormat:@"%@:",methodName];
    SEL action = NSSelectorFromString(fName);
    if([self respondsToSelector:action]){
        NSDictionary *balls = ((NSDictionary* (*)(id, SEL,NSArray*))[self methodForSelector:action])(self, action,ballArray);
        return balls;
    }
    else{
        
        return [self m7:ballArray];
    }
}
//每个section随机生成7个球
+ (NSDictionary *)m7:(NSArray *)ballArray{
    return [self randomFromBallArray:ballArray number:7];
}
//从数组中ballArray 的每个section0选择number个
+ (NSDictionary *)randomFromBallArray:(NSArray *)ballArray number:(NSInteger)number{
    NSMutableDictionary *tempDict = [NSMutableDictionary dictionary];
    NSMutableArray *sectionArray = [NSMutableArray arrayWithArray:ballArray];
    for(NSInteger i = 0; i < sectionArray.count; i++){
        NSMutableSet *set = [NSMutableSet set];
        SSCBallCellModel *model = ballArray[i];
        NSMutableArray *balls = [NSMutableArray arrayWithArray:model.ballArray];
        while (set.count < number) {
            NSInteger index = arc4random()%balls.count;
            SSCBallViewModel *viewModel = balls[index];
            
            BOOL isContain = false;
            for(NSSet *s in tempDict.allValues){
                if([s containsObject:viewModel.commit]){
                    isContain = true;
                    break;
                }
            }
            if (isContain) {
                continue;
            }
            [set addObject:viewModel.commit];
            [balls removeObject:viewModel];
        }
        [tempDict setObject:set forKey:[NSString stringWithFormat:@"%ld",i]];
    }
    return tempDict;
}
@end
