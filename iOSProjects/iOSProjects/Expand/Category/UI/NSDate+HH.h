//
//  NSDate+HH.h
//  iOSProjects
//
//  Created by funtSui on 2018/11/22.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (HH)

- (NSString *)stringWithFormat:(NSString *)format;

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;
@end

NS_ASSUME_NONNULL_END
