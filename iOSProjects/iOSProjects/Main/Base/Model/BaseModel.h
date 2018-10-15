//
//  BaseModel.h
//  HHToolCategory
//
//  Created by Mac on 2018/8/6.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
@property(nonatomic,copy) NSString *ID;  // <#注释#>


+ (instancetype)objectWithDic:(NSDictionary*)dic;

+ (NSArray*)objectsInArray:(NSArray<NSDictionary*>*)arr;
@end
