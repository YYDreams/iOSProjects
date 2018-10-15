//
//  NSString+HH.m
//  leyingyinggame
//
//  Created by TuMi on 2016/11/19.
//  Copyright © 2016年 TuMi. All rights reserved.
//

#import "NSString+HH.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSDateFormatter+Category.h"
#import <SSKeychain/SSKeychain.h>

@implementation NSString (HH)

+ (NSString*)getUUID
{
    NSString * uuid = [SSKeychain passwordForService:@"hh.jyFram.com" account:@"UUID"];
    
    if (uuid) return uuid;
    
    if ([uuid isEqualToString:@""]||!uuid)
    {
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        uuid = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuidRef));
        
        BOOL save = [SSKeychain setPassword:uuid forService:@"hh.jyFram.com" account:@"UUID"];
        if (!save)
        {
            NSLog(@"保存设备唯一标识出错了");
        }
    }
    
    return uuid;
}

- (BOOL)isEmptyString
{
    if (self == nil || self == NULL)
    {
        return YES;
    }
    
    if ([self isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    
    NSString *trimedString  = [self stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    trimedString = [trimedString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    trimedString = [trimedString stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([trimedString length] == 0)
    {
        return YES;
    }
    return NO;
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
}

- (NSString *)MD5
{
    const char *ptr = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

+ (BOOL)isMobilePhoneNumber:(NSString *)number
{
    //NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[013678]|8[0-9])\\d{8}$";
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0-9]|8[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:number];
}

#pragma mark - 验证手机号码格式

- (BOOL)isMobileNumber {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    //    NSString *mobile = @"^1(3[0-9]|5[0-35-9]|7[0-9]|8[025-9])\\d{8}$";
    //  ^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/
    NSString *mobile =
    @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    //  NSString *chinaMobile = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString *chinaMobile = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString *chinaUnicom = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    //  NSString *chinaTelecom = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
  /*
   13开头的后面跟0-9的任意8位数；
   
   15开头的后面跟除了4以外的0-9的任意8位数；
   
   18开头的后面跟0-9的任意8位数；
   
   17开头的后面跟0-8的任意8位数，或者17[^9]；
   
   147，145开头后面跟任意8位数；
   
   166开头的后面跟任意8位数；
   
   198，199开头后面跟任意8位数；
   
  //注意 现在最新的号码有属于199开头的
    **/
    NSString *chinaTelecom = @"^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}$";

//    NSString *chinaTelecom = @"^1[3|4|5|7|8][0-9]{9}$";
    
    NSPredicate *mobilePredicate =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    NSPredicate *cmPredicate =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chinaMobile];
    NSPredicate *cuPredicate =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chinaUnicom];
    NSPredicate *ctPredicate =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chinaTelecom];
    if ([mobilePredicate evaluateWithObject:self] ||
        [cmPredicate evaluateWithObject:self] ||
        [cuPredicate evaluateWithObject:self] ||
        [ctPredicate evaluateWithObject:self]) {
        return YES;
    }
    
    return NO;
}


+ (NSString *)getNowTimeTimestamp{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    return [NSString stringWithFormat:@"%.0f",interval];
}

+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}
//是否全是数字
- (BOOL)isAllNumber
{
    NSString *regex = @"^\\d+$";//是否全为数字
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    
    return isMatch;
}

+ (NSString*)timeShowWithFormatStyle:(NSString *)style timeInterval:(NSTimeInterval)secs{
    NSDateFormatter *dateFormatter = [NSDateFormatter shareInstance];
    if ([style length] == 0)
    {
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];// 不设置时默认
    }
    else
    {
        [dateFormatter setDateFormat:style];
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:secs/1000];
    
    return [dateFormatter stringFromDate:date];
}

+ (NSString*)timeShowWithFormatStyle:(NSString *)style time:(NSString *)time{
    
        NSDateFormatter *formatter = [NSDateFormatter shareInstance];
    
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
        NSDate *date = [formatter dateFromString:time];
    
        NSDateFormatter *lastFormatter =  [NSDateFormatter shareInstance];
    
    
    if ([style length] == 0) {
        
        [lastFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];// 不设置时默认
    } else {
        
        [lastFormatter setDateFormat:style];
    }
    
    return  [lastFormatter stringFromDate:date];
    
}


+ (NSString *)messageTimeShowWithTimeInterval: (NSTimeInterval)secs
{
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSString *todayString = [dateFormatter1 stringFromDate:[NSDate date]];
    todayString = [NSString stringWithFormat:@"%@ %@", todayString, @"00:00:00"];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *todayDate = [dateFormatter2 dateFromString:todayString];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:secs];
    
    if ([todayDate compare:date] == NSOrderedAscending || [todayDate compare:date] == NSOrderedSame)
    {
        // 今天
        if ([date timeIntervalSinceNow] > -10)
        {
            // 10s内
            return (@"刚刚");
        }
        else if ([date timeIntervalSinceNow] > -60)
        {
            // 1分钟内
            return [NSString stringWithFormat:@"%@%@", @((int)[date timeIntervalSinceNow]/(-1)), (@"秒前")];
        }
        else if ([date timeIntervalSinceNow] > -3600)
        {
            // 1小时内
            return [NSString stringWithFormat:@"%@%@", @((int)[date timeIntervalSinceNow]/(-60)), (@"分钟前")];
        }
        else
        {
            // 1天内
            return [NSString stringWithFormat:@"%@%@", @((int)[date timeIntervalSinceNow]/(-3600)), (@"小时前")];
        }
    }
    else if ([date timeIntervalSinceDate:todayDate] > -777600)
    {
        // 10天内
        return [NSString stringWithFormat:@"%@%@", @((int)([date timeIntervalSinceDate:todayDate]/(-86400)) + 1), (@"天前")];
    }
    else
    {
        // 10天之前 yy/MM/dd
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yy/MM/dd"];
        return [dateFormatter stringFromDate:date];
    }
}
- (CGFloat)widthForHeight:(CGFloat)height andFont:(int)fontSize
{
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    // 计算文本的大小
    CGSize sizeToFit = [self boundingRectWithSize:CGSizeMake(MAXFLOAT,height) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading                                         attributes:dic context:nil].size;
    
    return sizeToFit.width;
}

- (NSString*)keepTwoDecimalPlaces {
    double math = [self doubleValue];
    return [NSString stringWithFormat:@"%.2f",math];
}

- (CGSize)sizeForTitle:(NSString *)title font:(UIFont *)font{
    
    
    CGRect titleRect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil];
    
    
    
    return CGSizeMake(titleRect.size.width, titleRect.size.height);
    
}



@end
