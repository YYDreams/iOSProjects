//
//  HHTextView.m
//  iOSProjects
//
//  Created by flowerflower on 2018/11/12.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHTextView.h"

static HHTextView *instance = nil;
@implementation HHTextView

+ (instancetype)sharedInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}
@end
