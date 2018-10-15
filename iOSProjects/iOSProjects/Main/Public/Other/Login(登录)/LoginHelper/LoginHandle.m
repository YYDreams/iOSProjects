//
//  LoginHandle.m
//  iOSProjects
//
//  Created by flowerflower on 2018/8/20.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "LoginHandle.h"

@implementation LoginHandle
static LoginHandle * instance = nil;
static dispatch_once_t onceToken;
+ (instancetype)shareInstance{
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
        instance.userInfo = [[UserModel alloc]init];
        UserModel *saveModel = [NSKeyedUnarchiver unarchiveObjectWithFile:UserDataFilePath];
        if (saveModel) {
            instance.userInfo = saveModel;
        }
    });
    
    return instance;
}

+ (void)saveUserInfo:(UserModel *)userInfo{
    
    [NSKeyedArchiver archiveRootObject:userInfo toFile:UserDataFilePath];
    
}


+ (void)clearUserInfo{
    onceToken = 0; // 只有置成0,GCD才会认为它从未执行过.它默认为0.这样才能保证下次再次调用shareInstance的时候,再次创建对象.
    instance = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error;
    if ([fileManager removeItemAtPath:UserDataFilePath error:&error]) {
        
        NSLog(@"清除用户数据成功");
    }else{
        NSLog(@"清除用户数据失败:%@",error);
    }
    
    
}
@end
