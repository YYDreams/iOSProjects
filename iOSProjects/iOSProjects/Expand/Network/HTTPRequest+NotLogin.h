//
//  HTTPRequest+NotLogin.h
//  JYFarm
//
//  Created by LOVE on 2017/12/11.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "HTTPRequest.h"

@interface HTTPRequest (NotLogin)
// 用户未登录
+ (BOOL) singleLoginWithResult:(int)result;
@end
