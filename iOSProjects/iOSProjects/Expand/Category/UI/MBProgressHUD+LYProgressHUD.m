//
//  MBProgressHUD+LYProgressHUD.m
//  LYLawyerPlatform
//
//  Created by caohuihui on 16/9/7.
//  Copyright © 2016年 华海乐盈. All rights reserved.
//

#import "MBProgressHUD+LYProgressHUD.h"

@implementation MBProgressHUD (LYProgressHUD)
static int Time = 1; //决定显示的时间

+ (void)LY_ShowHUD:(BOOL)animation{
    [self LY_ShowHUD:nil animation:animation];
}

+ (void)LY_HideHUD:(BOOL)animation{
    [self LY_HideHUD:nil animation:animation];
}

+ (void)LY_ShowHUD:(UIView *)toView animation:(BOOL)animation{
    UIView *view = (toView == nil ? [UIApplication sharedApplication].keyWindow : toView);
    [MBProgressHUD showHUDAddedTo:view animated:animation];
}

+ (void)LY_HideHUD:(UIView *)toView animation:(BOOL)animation{
    UIView *view = (toView == nil ? [UIApplication sharedApplication].keyWindow : toView);
    [MBProgressHUD hideHUDForView:view animated:animation];
}

#pragma mark 显示信息
+ (void)LY_Show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = text;
    hud.detailsLabelFont = [UIFont systemFontOfSize:15];
    // 设置图片
//    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_background"]];;
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
//    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:Time];
}

#pragma mark 显示错误信息
+ (void)LY_ShowError:(NSString *)error toView:(UIView *)view{
    [self LY_Show:error icon:@"error.png" view:view];
}

+ (void)LY_ShowSuccess:(NSString *)success toView:(UIView *)view
{
    [self LY_Show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)LY_ShowMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.label.text = message;
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}

+ (void)LY_ShowSuccess:(NSString *)success
{
    [self LY_ShowSuccess:success toView:nil];
}

+ (void)LY_ShowError:(NSString *)error
{
    [self LY_ShowError:error toView:nil];
}
+ (void)LY_ShowError:(NSString *)error time:(int) time;
{
    [self LY_ShowError:error toView:nil];
    Time = time;
}
+ (MBProgressHUD *)LY_ShowMessage:(NSString *)message
{
    return [self LY_ShowMessage:message toView:nil];
}

+ (void)LY_HideHUDForView:(UIView *)view
{
    [self LY_HideHUD:view animation:YES];
}

+ (void)LY_HideHUD
{
    [self LY_HideHUDForView:nil];
}

//显示菊花转圈
+ (MBProgressHUD *)LY_ShowProgress:(NSString *)message{

 return [self zAlertProgressMessage:message to:[UIApplication sharedApplication].keyWindow];

}
+ (MBProgressHUD *)zAlertProgressMessage:(NSString *)message to:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.label.text = message;
//    
//    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.2f];
    
    return hud;
}
@end
