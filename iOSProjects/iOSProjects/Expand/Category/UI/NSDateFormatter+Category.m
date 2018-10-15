//
//  NSDateFormatter+Category.m
//  LYYGame
//
//  Created by YUJIABO on 17/3/14.
//  Copyright © 2017年 YUJIABO. All rights reserved.
//

#import "NSDateFormatter+Category.h"

@implementation NSDateFormatter (Category)

static NSDateFormatter *_instanceType = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceType = [[NSDateFormatter alloc]init];
    });
    
    return _instanceType;
  
}
@end
