//
//  NSObject+Runtime.m
//  LYYGame
//
//  Created by YUJIABO on 17/3/28.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation NSObject (Runtime)

- (void)swizzMethod:(SEL)newSel originMethod:(SEL)oriSel
{
    Class clazz = [self class];
    
    Method newMethod = class_getClassMethod(clazz, newSel);
    Method oriMethod = class_getClassMethod(clazz, oriSel);
    BOOL didAdd = class_addMethod(clazz, oriSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    
    if (didAdd)
    {
        class_replaceMethod(clazz, newSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    }
    else
    {
        method_exchangeImplementations(newMethod, oriMethod);
    }
}

+ (NSArray*)propertyNames
{
    return [[self class] propertyKeys];
}

+ (NSArray *)propertyKeys
{
    unsigned int propertyCount = 0;
    //获取属性列表
    objc_property_t * properties = class_copyPropertyList(self, &propertyCount);
    NSMutableArray * propertyNames = [NSMutableArray array];
    
    for (unsigned int i = 0; i < propertyCount; ++i) {
        objc_property_t property = properties[i];
        const char * name = property_getName(property);
        [propertyNames addObject:[NSString stringWithUTF8String:name]];
    }
    free(properties);
    return propertyNames;
}

+ (NSDictionary*)getPropertyType
{
    unsigned int propertyCount = 0;
    //获取属性列表
    objc_property_t * properties = class_copyPropertyList(self, &propertyCount);
    NSMutableDictionary * propertyDic = [NSMutableDictionary dictionary];
    
    for (unsigned int i = 0; i<propertyCount; i++)
    {
        objc_property_t property = properties[i];
        
        const char * name = property_getName(property);
        
        NSString *attrs = @(property_getAttributes(property));
        NSUInteger dotLoc = [attrs rangeOfString:@","].location;
        NSString *code = nil;
        NSUInteger loc = 1;
        if (dotLoc == NSNotFound)
        { // 没有,
            code = [attrs substringFromIndex:loc];
        }
        else
        {
            code = [attrs substringWithRange:NSMakeRange(loc, dotLoc - loc)];
        }
        
        Class type;
        if (code.length > 3 && [code hasPrefix:@"@\""])
        {
          // 去掉@"和"，截取中间的类型名称
          type = [[code substringWithRange:NSMakeRange(2, code.length - 3)] class];
        }
        
        if (!type)
        {
            type = [NSNumber class];
        }
        [propertyDic setValue:type forKey:@(name)];
    }
    
    return propertyDic;
}
@end
