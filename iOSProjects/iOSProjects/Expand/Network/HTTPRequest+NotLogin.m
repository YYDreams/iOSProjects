//
//  HTTPRequest+NotLogin.m
//  JYFarm
//
//  Created by LOVE on 2017/12/11.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "HTTPRequest+NotLogin.h"
//#import "JYLoginController.h"
#import "BaseNavViewController.h"
@implementation HTTPRequest (NotLogin)

// 用户未登录
+ (BOOL) singleLoginWithResult:(int)result{
    
    if (result == -1000) {
        
        [self  showLoginTips:@"您的账号未登录"];
        return  YES;
    }
    
    return NO;

}

+ (void)showLoginTips:(NSString *)tip{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:(tip) preferredStyle:UIAlertControllerStyleAlert];
    
    __block UIViewController * rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIAlertAction *loginOutAction = [UIAlertAction actionWithTitle:(@"重新登录") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
                                     {
//                                         //移除cookie
//                                         [HTTPRequest removeCookie];
//                                         //清空用户登录信息
//                                         [LH loginOutDataHandle];
//                          
//                                         //弹出登录界面
//                                         JYLoginController *loginVc = [[JYLoginController alloc]init];
//                                         loginVc.showType = LoginVcShowTypePresent;
//                                         BaseNavViewController *nav = [[BaseNavViewController alloc]initWithRootViewController:loginVc];
//                                         [rootVC presentViewController:nav animated:YES completion:nil];
                                     }];
    
    [alertController addAction:loginOutAction];
    
    [rootVC presentViewController:alertController animated:YES completion:nil];
    
    
    
}
@end
