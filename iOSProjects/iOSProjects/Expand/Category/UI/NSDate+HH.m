//
//  NSDate+HH.m
//  iOSProjects
//
//  Created by funtSui on 2018/11/22.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "NSDate+HH.h"

@implementation NSDate (HH)


- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}


+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateString];
}


@end
