//
//  SqliteTool.h
//  数据存储
//
//  Created by 花花 on 2017/9/13.
//  Copyright © 2017年 花花. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface SqliteTool : NSObject

//
+ (NSArray *)userInfo;

+ (BOOL)saveUserInfo:(UserModel *)userInfo;


//bug
+ (void)clearInfo;
@end
