//
//  UIButton+HHAddition.h
//  Addition
//
//  Created by 花花 on 2017/1/17.
//  Copyright © 2017年 花花. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIButton (HHAddition)

/**
 创建文本按钮(title/fontSize/normalColor/higlightedColor)

 @param title 标题文字
 @param fontSize 标题文字
 @param normalColor 默认颜色
 @param higlightedColor 高亮颜色
 @return UIButton
 */
+ (instancetype)buttonTitle:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)higlightedColor;


/**
 创建文本按钮（title/fontSize/normalColor/higlightedColor/backgroundImageName）

 @param title 标题文字
 @param fontSize 字体大小
 @param normalColor 默认颜色
 @param higlightedColor 高亮颜色
 @param backgroundImageName 背景图像名称
 @return UIButton
 */
+ (instancetype)buttonTitle:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)higlightedColor backgroundImageName:(NSString *)backgroundImageName;



/**
 创建图像按钮(imageName/backgroundImageName)

 @param imageName 图像名称
 @param backgroundImageName 背景图像名称
 @return UIButton
 */
+ (instancetype)imageButton:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName;


/**
 创建按钮(title/frame/targetaction)

 @param title <#title description#>
 @param frame <#frame description#>
 @param target <#target description#>
 @param action <#action description#>
 @return <#return value description#>
 */
+(instancetype)buttontitle:(NSString *)title frame:( CGRect)frame target:(id)target action:(SEL)action;


+ (instancetype)buttontitle:(NSString *)title titleColor:(UIColor *)titleColor BackgroundColor:(UIColor *)BackgroundColor target:(id)target action:(SEL)action;

///圆角的按钮
+ (instancetype)buttonwithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action cornerRadius:(CGFloat)radius;
///带渐变色与圆角的按钮
+ (instancetype)gradientButtonwithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action cornerRadius:(CGFloat)radius;

///带边框与圆角的按钮
+ (instancetype)buttonwithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action cornerRadius:(CGFloat)radius bgColor:(UIColor *)bgColor;

+(instancetype)jy_buttontitle:(NSString *)title titleColor:(UIColor *)titleColor frame:(CGRect)frame target:(id)target action:(SEL)action  fontSize:(CGFloat)fontSize bgImageName:(NSString *)bgImageName;

- (void)hh_defaultStyleWithNormalTitleColor:(UIColor *)titleColor andHighTitleColor:(UIColor *)highTitleColor andBorderColor:(UIColor *)borderColor withcornerRadius:(CGFloat)cornerRadius;
@end
