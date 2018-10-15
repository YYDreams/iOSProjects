//
//  AFHTTPSessionManager+Config.h
//  LYYGame
//
//  Created by YUJIABO on 17/3/13.
//  Copyright © 2017年 YUJIABO. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface AFHTTPSessionManager (Config)
//参数
@property (nonatomic, strong) NSMutableDictionary * parmars;
//基本设置
- (void)configSetting;
//配置基本参数
+ (NSDictionary*)configBaseParmars:(NSDictionary*)parmars;

@end
