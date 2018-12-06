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






- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super init]) {
        Class c = self.class;
        while (c && c != [NSObject class]) {
            unsigned int count = 0;
            Ivar *ivars = class_copyIvarList(c, &count);
            for (int i = 0; i < count; i++) {
                
                NSString *key = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
                
                id value = [aDecoder decodeObjectForKey:key];
                if(value)[self setValue:value forKey:key];
                
            }
            c = [c superclass];
            free(ivars);
        }
        
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    Class c = self.class;
    while (c && c != [NSObject class]) {
        unsigned int count = 0;
        
        Ivar *ivars = class_copyIvarList(c, &count);
        
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            id value = [self valueForKey:key];
            
            [aCoder encodeObject:value forKey:key];
        }
        c = [c superclass];
        free(ivars);
    }
}



@end
