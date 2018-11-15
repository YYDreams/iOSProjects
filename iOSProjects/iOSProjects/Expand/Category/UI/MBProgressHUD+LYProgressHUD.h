//
//  MBProgressHUD+LYProgressHUD.h
//  LYLawyerPlatform
//
//  Created by caohuihui on 16/9/7.
//  Copyright © 2016年 华海乐盈. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (LYProgressHUD)
/**
 window上展示提示语
 
 @param message 提示语内容
 */
+ (void)showTipMessageInWindow:(NSString*)message;

/**
 当前view上展示提示语
 
 @param message 提示语内容
 */
+ (void)showTipMessageInView:(NSString*)message;


/**
 window上展示提示语
 
 @param message 提示语内容
 @param aTimer progress保持时间
 */
+ (void)showTipMessageInWindow:(NSString*)message timer:(int)aTimer;

/**
 view上展示提示语
 
 @param message 提示语内容
 @param aTimer progress保持时间
 */
+ (void)showTipMessageInView:(NSString*)message timer:(int)aTimer;

/**
 window上展示提示语
 
 @param message 提示语内容
 @param aTimer 保持时间
 @param color 背景颜色
 */
+ (void)showTipMessageInWindow:(NSString*)message timer:(int)aTimer backColor: (UIColor *)color;

/**
 wiew上展示提示语
 
 @param message 提示语内容
 @param aTimer 保持时间
 @param color 背景颜色
 */
+ (void)showTipMessageInView:(NSString*)message timer:(int)aTimer backColor: (UIColor *)color;


/**
 window展示activity提示语
 
 @param message 提示语内容
 */
+ (void)showActivityMessageInWindow:(NSString*)message;

/**
 view展示activity提示语
 
 @param message 提示语内容
 */
+ (void)showActivityMessageInView:(NSString*)message;

+ (void)showActivityMessageInView:(NSString*)message inView:(UIView *)view;
+ (void)hideHUDFromView:(UIView *)view;

/**
 window展示activity提示语
 
 @param message 提示语内容
 @param aTimer 保持时间
 */
+ (void)showActivityMessageInWindow:(NSString*)message timer:(int)aTimer;

/**
 view展示activity提示语
 
 @param message 提示语内容
 @param aTimer 保持时间
 */
+ (void)showActivityMessageInView:(NSString*)message timer:(int)aTimer;

/**
 window展示activity提示语
 
 @param message 提示语内容
 @param aTimer 保持时间
 @param color 背景颜色
 */
+ (void)showActivityMessageInWindow:(NSString*)message timer:(int)aTimer  backColor: (UIColor *)color;

/**
 view展示activity提示语
 
 @param message 提示语内容
 @param aTimer 保持时间
 @param color 背景颜色
 */
+ (void)showActivityMessageInView:(NSString*)message timer:(int)aTimer  backColor: (UIColor *)color;


/**
 显示成功
 
 @param Message 成功提示语
 */
+ (void)showSuccessMessage:(NSString *)Message;

/**
 显示错误
 
 @param Message 错误提示语
 */
+ (void)showErrorMessage:(NSString *)Message;

/**
 显示信息
 
 @param Message 信息提示语
 */
+ (void)showInfoMessage:(NSString *)Message;

/**
 显示警告
 
 @param Message 警告提示语
 */
+ (void)showWarnMessage:(NSString *)Message;

/**
 显示成功
 
 @param Message 成功提示语
 @param color 背景颜色
 */
+ (void)showSuccessMessage:(NSString *)Message backColor: (UIColor *)color;

/**
 显示错误
 
 @param Message 错误提示语
 @param color 背景颜色
 */
+ (void)showErrorMessage:(NSString *)Message backColor: (UIColor *)color;

/**
 显示信息
 
 @param Message 信息提示语
 @param color 背景颜色
 */
+ (void)showInfoMessage:(NSString *)Message backColor: (UIColor *)color;

/**
 显示警告
 
 @param Message 警告提示语
 @param color 背景颜色
 */
+ (void)showWarnMessage:(NSString *)Message backColor: (UIColor *)color;


/**
 windou上显示自定义图片和提示语
 
 @param iconName 图片名
 @param message 提示语
 */
+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message;

/**
 view上显示自定义图片和提示语
 
 @param iconName 图片名
 @param message 提示语
 */
+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message;

/**
 windou上显示自定义图片和提示语
 
 @param iconName 图片
 @param message 提示语
 @param color 背景颜色
 */
+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message backColor: (UIColor *)color;

/**
 view上显示自定义图片和提示语
 
 @param iconName 图片
 @param message 提示语
 @param color 背景颜色
 */
+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message backColor: (UIColor *)color;




/**
 隐藏HUD
 */
+ (void)hideHUD;

+ (void)showSucc:(NSString *)msg inView:(UIView *)view;
+ (void)showErr :(NSString *)msg inView:(UIView *)view;
+ (void)showTip :(NSString *)msg inView:(UIView *)view;


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
