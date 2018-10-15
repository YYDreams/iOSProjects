//
//  BaseModel.m
//  HHToolCategory
//
//  Created by Mac on 2018/8/6.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"ID":@"id"};
}
+ (instancetype)objectWithDic:(NSDictionary *)dic
{
    //容错处理
    if (![dic isKindOfClass:[NSDictionary class]]||!dic)
    {
        return nil;
    }
    
    //获取子类名
    NSString * className =  [NSString stringWithUTF8String:object_getClassName(self)];
    
    return [NSClassFromString(className) mj_objectWithKeyValues:dic];
}

+ (NSArray*)objectsInArray:(NSArray<NSDictionary*>*)arr
{
    //获取子类名
    NSString * className =  [NSString stringWithUTF8String:object_getClassName(self)];
    
    return [NSClassFromString(className) mj_objectArrayWithKeyValuesArray:arr];
}

@end
