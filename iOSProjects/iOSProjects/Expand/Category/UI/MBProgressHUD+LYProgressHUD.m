//
//  MBProgressHUD+LYProgressHUD.m
//  LYLawyerPlatform
//
//  Created by caohuihui on 16/9/7.
//  Copyright © 2016年 华海乐盈. All rights reserved.
//

#import "MBProgressHUD+LYProgressHUD.h"
#define imageHeight 228
#define imageWidth 172
@implementation MBProgressHUD (LYProgressHUD)
static int Time = 1; //决定显示的时间


+ (MBProgressHUD*)createMBProgressHUDviewWithMessage:(NSString*)message isWindiw:(BOOL)isWindow backGroundColor: (UIColor *)backColor
{
    [self hideHUD];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideHUD];
    });
    
    
    
    UIView  *view = isWindow? (UIView*)[UIApplication sharedApplication].delegate.window:[self getCurrentUIVC].view;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    
    hud.label.text=message?message:@"";// 加载中.....
    hud.label.font=[UIFont systemFontOfSize:15];
    
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.88];
    hud.animationType = MBProgressHUDAnimationZoomIn;//放大消失
//    hud.activityIndicatorColor = [UIColor whiteColor];
    hud.backgroundView.color = backColor? backColor:[UIColor clearColor];
    
    return hud;
}
#pragma mark-------------------- show Tip----------------------------

// clearColor
+ (void)showTipMessageInWindow:(NSString*)message
{
    [self showTipMessage:message isWindow:true timer:1 backColor:nil];
}
+ (void)showTipMessageInView:(NSString*)message
{
    [self showTipMessage:message isWindow:false timer:1 backColor:nil];
}
+ (void)showTipMessageInWindow:(NSString*)message timer:(int)aTimer
{
    [self showTipMessage:message isWindow:true timer:aTimer backColor:nil];
}
+ (void)showTipMessageInView:(NSString*)message timer:(int)aTimer
{
    [self showTipMessage:message isWindow:false timer:aTimer backColor:nil];
}

// WithColor
+ (void)showTipMessageInWindow:(NSString*)message backColor:(UIColor *)color
{
    [self showTipMessage:message isWindow:true timer:1 backColor:color];
}
+ (void)showTipMessageInView:(NSString*)message backColor:(UIColor *)color
{
    [self showTipMessage:message isWindow:false timer:1 backColor:color];
}
+ (void)showTipMessageInWindow:(NSString*)message timer:(int)aTimer backColor:(UIColor *)color
{
    [self showTipMessage:message isWindow:true timer:aTimer backColor:color];
}
+ (void)showTipMessageInView:(NSString*)message timer:(int)aTimer backColor:(UIColor *)color
{
    [self showTipMessage:message isWindow:false timer:aTimer backColor:color];
}

+ (void)showTipMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(int)aTimer backColor: (UIColor *)backColor
{
    MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow backGroundColor:backColor];
    hud.mode = MBProgressHUDModeText;
    hud.label.textColor = [UIColor whiteColor];
    [hud hideAnimated:YES afterDelay:aTimer];
}



#pragma mark-------------------- show Activity----------------------------

// clearColor
+ (void)showActivityMessageInWindow:(NSString*)message
{
    [self showActivityMessage:@"" isWindow:true timer:0 backColr:nil];
}
+ (void)showActivityMessageInView:(NSString*)message
{
    [self showActivityMessage:@"" isWindow:false timer:0 backColr:nil];
}
+ (void)showActivityMessageInWindow:(NSString*)message timer:(int)aTimer
{
    [self showActivityMessage:message isWindow:true timer:aTimer backColr:nil];
}
+ (void)showActivityMessageInView:(NSString*)message timer:(int)aTimer
{
    [self showActivityMessage:message isWindow:false timer:aTimer backColr:nil];
}


// backColor
+ (void)showActivityMessageInWindow:(NSString*)message backColor:(UIColor *)color
{
    [self showActivityMessage:message isWindow:true timer:0 backColr:color];
}
+ (void)showActivityMessageInView:(NSString*)message backColor:(UIColor *)color
{
    [self showActivityMessage:message isWindow:false timer:0 backColr:color];
}
+ (void)showActivityMessageInWindow:(NSString*)message timer:(int)aTimer backColor:(UIColor *)color
{
    [self showActivityMessage:message isWindow:true timer:aTimer backColr:color];
}
+ (void)showActivityMessageInView:(NSString*)message timer:(int)aTimer backColor:(UIColor *)color
{
    [self showActivityMessage:message isWindow:false timer:aTimer backColr:color];
}


+ (void)showActivityMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(int)aTimer backColr :(UIColor *)color
{
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow backGroundColor:color];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [self gifImages];
    hud.bezelView.backgroundColor = [UIColor clearColor];
    hud.bezelView.color = [UIColor colorWithWhite:1 alpha:0.0];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.label.textColor = [UIColor whiteColor];
    if (aTimer>0) {
        [hud hideAnimated:YES afterDelay:aTimer];
    }
}
#pragma mark-------------------- show Image----------------------------

// clearColor
+ (void)showSuccessMessage:(NSString *)Message
{
    NSString *name =@"MBHUD_Success";
    [self showCustomIconInWindow:name message:Message];
}
+ (void)showErrorMessage:(NSString *)Message
{
    NSString *name =@"MBHUD_Error";
    [self showCustomIconInWindow:name message:Message];
}
+ (void)showInfoMessage:(NSString *)Message
{
    NSString *name =@"MBHUD_Info";
    [self showCustomIconInWindow:name message:Message];
}
+ (void)showWarnMessage:(NSString *)Message
{
    NSString *name =@"MBHUD_Warn";
    [self showCustomIconInWindow:name message:Message];
}
+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message
{
    [self showCustomIcon:iconName message:message isWindow:true backColor:nil];
    
}
+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message
{
    [self showCustomIcon:iconName message:message isWindow:false backColor:nil];
}

// backColor
+ (void)showSuccessMessage:(NSString *)Message backColor:(UIColor *)color
{
    NSString *name =@"MBHUD_Success";
    [self showCustomIconInWindow:name message:Message backColor:color];
}
+ (void)showErrorMessage:(NSString *)Message backColor:(UIColor *)color
{
    NSString *name =@"MBHUD_Error";
    [self showCustomIconInWindow:name message:Message backColor:color];
}
+ (void)showInfoMessage:(NSString *)Message backColor:(UIColor *)color
{
    NSString *name =@"MBHUD_Info";
    [self showCustomIconInWindow:name message:Message backColor:color];
}
+ (void)showWarnMessage:(NSString *)Message backColor:(UIColor *)color
{
    NSString *name =@"MBHUD_Warn";
    [self showCustomIconInWindow:name message:Message backColor:color];
}
+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message backColor:(UIColor *)color
{
    [self showCustomIcon:iconName message:message isWindow:true backColor:color];
    
}
+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message backColor:(UIColor *)color
{
    [self showCustomIcon:iconName message:message isWindow:false backColor:color];
}

+ (void)showCustomIcon:(NSString *)iconName message:(NSString *)message isWindow:(BOOL)isWindow backColor:(UIColor *)color
{
    
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow backGroundColor:color];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.textColor = [UIColor whiteColor];
    hud.label.numberOfLines = 0;
    [hud hideAnimated:YES afterDelay:1];
    
}
+ (void)hideHUD
{
    UIView  *winView =(UIView*)[UIApplication sharedApplication].delegate.window;
    [MBProgressHUD hideHUDForView:winView animated:YES];
    [MBProgressHUD hideHUDForView:[self getCurrentUIVC].view animated:YES];
}

//获取当前屏幕显示的viewcontroller
+(UIViewController *)getCurrentWindowVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tempWindow in windows)
        {
            if (tempWindow.windowLevel == UIWindowLevelNormal)
            {
                window = tempWindow;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
    {
        result = nextResponder;
    }
    else
    {
        result = window.rootViewController;
    }
    return  result;
}
+(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [[self class]  getCurrentWindowVC ];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}


+(void)setBackGroundColor:(UIColor *)backGroundColor {
    MBProgressHUD * hud = [MBProgressHUD new];
    hud.backgroundView.backgroundColor = backGroundColor;
}

+(UIImageView *)gifImages {
    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageWidth, imageHeight)];
    NSMutableArray * imageArr = [NSMutableArray array];
//    if ([FSProjectConfig sharedConfig].matchColor == FSMatchColors_HUANG
//        ||[FSProjectConfig sharedConfig].matchColor == FSMatchColors_HONG ) {
//        for (NSInteger i = 1; i <= 3; i ++) {
//            NSString * imageName = [NSString stringWithFormat:@"天天LOAD000%ld.png", i];
//            [imageArr addObject:[UIImage imageNamed:imageName]];
//        }
//        image.animationDuration = 3/12;
//    }
//    else
//    {
        for (NSInteger i = 1; i < 16; i ++) {
            NSString * imageName = [NSString stringWithFormat:@"loadImg%ld.png", i];
            [imageArr addObject:[UIImage imageNamed:imageName]];
        }
        image.animationDuration = 1.5;
//    }
    
    image.animationImages = imageArr;
    
    [image startAnimating];
    return image;
}

/**
 view展示activity提示语
 
 @param message 提示语内容
 */
+ (void)showActivityMessageInView:(NSString*)message inView:(UIView *)view{
    MBProgressHUD * hud = [MBProgressHUD HUDForView:view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.margin = 10;
        hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.label.font=[UIFont systemFontOfSize:14];
        hud.label.textColor = [UIColor whiteColor];
        hud.removeFromSuperViewOnHide = YES;
        hud.bezelView.backgroundColor = [UIColor blackColor];
        hud.animationType = MBProgressHUDAnimationFade;
        
//        hud.activityIndicatorColor = [UIColor whiteColor];
        hud.backgroundView.color = [UIColor clearColor];
    }
    hud.label.text = message;// 加载中.....
}
+ (void)hideHUDFromView:(UIView *)view{
    [MBProgressHUD hideHUDForView:view animated:YES];
}

// clearColor
+ (void)showSucc:(NSString *)msg inView:(UIView *)view
{
    MBProgressHUD * hud = [self getDefaultHUD:view];
    hud.label.text = msg;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBHUD_Success"]];
    [hud hideAnimated:YES afterDelay:1];
    hud.label.textColor = [UIColor whiteColor];
}
+ (void)showErr:(NSString *)msg inView:(UIView *)view
{
    MBProgressHUD * hud = [self getDefaultHUD:view];
    hud.label.text = msg;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBHUD_Error"]];
    [hud hideAnimated:YES afterDelay:1];
    hud.label.textColor = [UIColor whiteColor];
}
+ (void)showTip:(NSString *)msg inView:(UIView *)view
{
    if (!msg) {
        return;
    }
    MBProgressHUD * hud = [self getDefaultHUD:view];
    hud.label.text = msg;
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:1];
    hud.label.textColor = [UIColor whiteColor];
}
+ (MBProgressHUD *)getDefaultHUD:(UIView *)view{
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD * hud = [MBProgressHUD HUDForView:view];
    if (hud) {
        return hud;
    }
    hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.margin = 10;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.label.font = [UIFont systemFontOfSize:15];
    hud.label.numberOfLines = 0;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.animationType = MBProgressHUDAnimationFade;
    hud.backgroundView.color = [UIColor clearColor];
    return hud;
}


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
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont systemFontOfSize:15];
    // 设置图片
//    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_background"]];;
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
 // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:Time];
    
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
    hud.label.text = message;
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
