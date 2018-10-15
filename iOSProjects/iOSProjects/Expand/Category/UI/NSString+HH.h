//
//  NSString+HH.h
//  leyingyinggame
//
//  Created by TuMi on 2016/11/19.
//  Copyright © 2016年 TuMi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HH)

+ (NSString*)getUUID;
- (BOOL)isEmptyString;

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

- (NSString *)MD5;

+ (BOOL)isMobilePhoneNumber:(NSString *)number;

- (BOOL)isAllNumber;

- (BOOL)isMobileNumber;

/**
 可自定义时间格式显示

 @param style 时间格式 不设置style默认为yyyy-MM-dd HH:mm:ss
 @param secs 时间戳
 @return 转换后的时间字符串
 */
+ (NSString*)timeShowWithFormatStyle:(NSString *)style timeInterval:(NSTimeInterval)secs;


/**
 可自定义时间格式显示
 
 @param style 时间格式 不设置style默认为yyyy-MM-dd HH:mm:ss
 @param time 时间
 @return 转换后的时间字符串
 */

+ (NSString*)timeShowWithFormatStyle:(NSString *)style time:(NSString *)time;


/**
 在消息中显示的时间

 @param secs 时间戳
 @return 转换后的时间字符串
 */
+ (NSString *)messageTimeShowWithTimeInterval: (NSTimeInterval)secs;

/**
 获取字符串宽度
 @param fontSize 字体大小
 @return 宽度
 */
- (CGFloat)widthForHeight:(CGFloat)height andFont:(int)fontSize;

////获取当前的时间
+(NSString*)getCurrentTimes;


+ (NSString *)getNowTimeTimestamp;

- (NSString*)keepTwoDecimalPlaces ;


- (CGSize)sizeForTitle:(NSString *)title font:(UIFont *)font;


@end
