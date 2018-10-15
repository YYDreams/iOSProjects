//
//  AFHTTPSessionManager+Config.m
//  LYYGame
//
//  Created by YUJIABO on 17/3/13.
//  Copyright © 2017年 YUJIABO. All rights reserved.
//

#import "AFHTTPSessionManager+Config.h"
//#import "LoginHandle.h"

#import <objc/runtime.h>

static void * Parameter = (void *)@"parameter";

@implementation AFHTTPSessionManager (Config)

- (NSMutableDictionary*)parmars
{
    return objc_getAssociatedObject(self, Parameter);
}

- (void)setParmars:(NSMutableDictionary *)parmars
{
    objc_setAssociatedObject(self, Parameter, parmars, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)configSetting
{
   // 跳过ssl验证
   self.securityPolicy.allowInvalidCertificates=NO;
    //设置请求超时
   self.requestSerializer.timeoutInterval = 15;
}

+ (NSDictionary*)configBaseParmars:(NSDictionary *)parmars
{
    //有的接口不需要平台类型这个参数  传一个noPlatformTerminal:@(1)在parmars中
    BOOL terminal = [parmars[kNoTerminalKey] boolValue];
    if (!parmars||![parmars isKindOfClass:[NSDictionary class]])
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        dic[@"token"] = LH.token;
//        dic[@"userId"] = LH.userId;
//        dic[@"platformTerminal"] = @([self platform]);
//        dic[@"terminal"] = @([self platform]);
        
        return dic;
    }
    
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:parmars];
    //统一添加country，token字段
//    dic[@"token"] = LH.token;
//    dic[@"userId"] = LH.userId;
//    dic[@"platformTerminal"] = @([self platform]);
    
    if (!terminal) {//没有传1,表示需要设置平台
//        dic[@"terminal"] = @([self platform]);
    }
//    [dic removeObjectForKey:kNoTerminalKey];
    return dic;
}


@end
