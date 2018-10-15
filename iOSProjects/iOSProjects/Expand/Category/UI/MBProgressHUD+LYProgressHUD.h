//
//  MBProgressHUD+LYProgressHUD.h
//  LYLawyerPlatform
//
//  Created by caohuihui on 16/9/7.
//  Copyright © 2016年 华海乐盈. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (LYProgressHUD)

+ (void)LY_ShowHUD:(BOOL)animation;
+ (void)LY_HideHUD:(BOOL)animation;

+ (void)LY_ShowHUD:(UIView *)toView animation:(BOOL)animation;

+ (void)LY_HideHUD:(UIView *)toView animation:(BOOL)animation;

+ (void)LY_ShowSuccess:(NSString *)success toView:(UIView *)view;
+ (void)LY_ShowError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)LY_ShowMessage:(NSString *)message toView:(UIView *)view;


+ (void)LY_ShowSuccess:(NSString *)success;
+ (void)LY_ShowError:(NSString *)error;
+ (void)LY_ShowError:(NSString *)error time:(int) time;

+ (MBProgressHUD *)LY_ShowMessage:(NSString *)message;

+ (void)LY_HideHUDForView:(UIView *)view;
+ (void)LY_HideHUD;

//显示菊花转圈
+ (MBProgressHUD *)LY_ShowProgress:(NSString *)message;
@end
