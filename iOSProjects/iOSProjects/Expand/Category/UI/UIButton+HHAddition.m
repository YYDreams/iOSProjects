//
//  UIButton+HHAddition.m
//  Addition
//
//  Created by 花花 on 2017/1/17.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "UIButton+HHAddition.h"

@implementation UIButton (HHAddition)



/**
 创建文本按钮
 
 @param title 标题文字
 @param fontSize 标题文字
 @param normalColor 默认颜色
 @param higlightedColor 高亮颜色
 @return UIButton
 */
+ (instancetype)buttonTitle:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)higlightedColor{


    return [self buttonTitle:title fontSize:fontSize normalColor:normalColor highlightedColor:higlightedColor backgroundImageName:nil];

}


/**
 创建文本按钮 <比上面多出一个背景图片>
 
 @param title 标题文字
 @param fontSize 字体大小
 @param normalColor 默认颜色
 @param higlightedColor 高亮颜色
 @param backgroundImageName 背景图像名称
 @return UIButton
 */
+ (instancetype)buttonTitle:(NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)higlightedColor backgroundImageName:(NSString *)backgroundImageName{
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setTitleColor:normalColor forState:UIControlStateNormal];
    [btn setTitleColor:higlightedColor forState:UIControlStateHighlighted];
    btn.titleLabel.font =[UIFont systemFontOfSize:fontSize];
    
    if (backgroundImageName != nil) {
        [btn setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
        
        
        NSString *backgroundImageNameHL = [backgroundImageName stringByAppendingString:@"_highlighted"];
        [btn setBackgroundImage:[UIImage imageNamed:backgroundImageNameHL] forState:UIControlStateHighlighted];
        
        
    }
    [btn sizeToFit];
    
    return btn;

}



/**
 创建图像按钮
 
 @param imageName 图像名称
 @param backgroundImageName 背景图像名称
 @return UIButton
 */
+ (instancetype)imageButton:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName{
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn  setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    NSString *imageNameHL = [imageName stringByAppendingString:@"_highlighted"];
    [btn setImage:[UIImage imageNamed:imageNameHL] forState:UIControlStateHighlighted];
    
    [btn setBackgroundImage:[UIImage imageNamed:backgroundImageName] forState:UIControlStateNormal];
    
    NSString *backgroundImageNameHL = [backgroundImageName stringByAppendingString:@"_highlighted"];
    [btn setBackgroundImage:[UIImage imageNamed:backgroundImageNameHL] forState:UIControlStateHighlighted];
    
    [btn sizeToFit];
    
    
    return btn;

}


+(instancetype)buttontitle:(NSString *)title frame:( CGRect)frame target:(id)target action:(SEL)action{

    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn setBackgroundColor:[UIColor colorWithHexString:@"fa2850"]];
//    btn.layer.cornerRadius =5.0;
//    btn.layer.masksToBounds = YES;
    [btn setFrame:frame];
    [btn addTarget:target  action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;

}

+ (instancetype)buttontitle:(NSString *)title titleColor:(UIColor *)titleColor BackgroundColor:(UIColor *)BackgroundColor target:(id)target action:(SEL)action{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setBackgroundColor: BackgroundColor];
    [btn addTarget:target  action:action forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

///带渐变色与圆角的按钮
+ (instancetype)buttonwithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action cornerRadius:(CGFloat)radius{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.backgroundColor = kThemeColor;
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = radius;
    btn.layer.masksToBounds = YES;
    btn.titleLabel.font = kFont(15);
    return btn; 
}
///带渐变色与圆角的按钮
+ (instancetype)gradientButtonwithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action cornerRadius:(CGFloat)radius{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.backgroundColor = kThemeColor;
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = btn.bounds;
//    [btn.layer addSublayer:gradientLayer];
//    gradientLayer.startPoint = CGPointMake(0.0, 0.5);
//    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
//    gradientLayer.colors = @[(__bridge id)UIColorFromRGB(0x00c6ff).CGColor,
//                             (__bridge id)UIColorFromRGB(0x0072ff).CGColor];
//
//    gradientLayer.locations = @[@(0.0f), @(1.0f)];
    btn.layer.cornerRadius = radius;
    btn.layer.masksToBounds = YES;
    btn.titleLabel.font = kFont(15);
    return btn;
}

///带边框与圆角的按钮
+ (instancetype)buttonwithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action cornerRadius:(CGFloat)radius bgColor:(UIColor *)bgColor {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.backgroundColor = bgColor;
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    btn.layer.cornerRadius = radius;
    btn.layer.masksToBounds = YES;

    btn.titleLabel.font = kFont(15);
    return btn;
}

+(instancetype)jy_buttontitle:(NSString *)title titleColor:(UIColor *)titleColor frame:(CGRect)frame target:(id)target action:(SEL)action  fontSize:(CGFloat)fontSize bgImageName:(NSString *)bgImageName{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target  action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = kFont(fontSize);
    [btn setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    
    return btn;
    
    
}

- (void)hh_defaultStyleWithNormalTitleColor:(UIColor *)titleColor  andHighTitleColor:(UIColor *)highTitleColor andBorderColor:(UIColor *)borderColor withcornerRadius:(CGFloat)cornerRadius{
    
    
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    [self setAdjustsImageWhenHighlighted:NO];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self setTitleColor:highTitleColor forState:UIControlStateHighlighted];
    [self setTitleColor:highTitleColor forState:UIControlStateSelected];
    
    self.layer.borderColor = [borderColor CGColor];
    
}


@end
