//
//  NSObject+Runtime.h
//  LYYGame
//
//  Created by YUJIABO on 17/3/28.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Runtime)
//两个方法交换
- (void)swizzMethod:(SEL)newSel originMethod:(SEL)oriSel;
//获取类的属性名数组
+ (NSArray*)propertyNames;
//获取类的属性类型字典  属性名:属性类型
+ (NSDictionary*)getPropertyType;

@end
