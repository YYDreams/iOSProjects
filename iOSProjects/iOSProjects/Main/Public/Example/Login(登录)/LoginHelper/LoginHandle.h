//
//  LoginHandle.h
//  iOSProjects
//
//  Created by flowerflower on 2018/8/20.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"



#define LH [LoginHandle shareInstance]
@interface LoginHandle : NSObject


@property(nonatomic,strong)UserModel *userInfo;

+ (instancetype)shareInstance;

//保存用户信息
+ (void)saveUserInfo:(UserModel *)userInfo;

//清除用户信息
+ (void)clearUserInfo;


@end
