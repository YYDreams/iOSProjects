//
//  SSCHistoryModel.m
//  iOSProjects
//
//  Created by funtSui on 2018/11/30.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "SSCHistoryModel.h"

@implementation SSCHistoryModel

-(BOOL)hasBall{
    NSArray *numArr = [self.period_code componentsSeparatedByString:@","];
    return numArr.count > 0;
}
@end
