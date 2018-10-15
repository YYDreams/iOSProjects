//
//  NSArray+NSFoundation.m
//  
//
//  Created by 花花 on 15/11/12.
//
//

#import "NSArray+NSFoundation.h"

@implementation NSArray (NSFoundation)
//安全使用数组
-(id)safeObjectAtIndex:(NSUInteger)index
{
    if ([self isKindOfClass:[NSArray class]])
    {
        if (self.count)
        {
            if (self.count>index)
            {
                return self[index];
            }
        }
    }
    
    return nil;
}
@end
