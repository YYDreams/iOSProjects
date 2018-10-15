//
//  UIBarButtonItem+HHAddition.m
//  Addition
//
//  Created by 花花 on 2017/1/17.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "UIBarButtonItem+HHAddition.h"
#import "UIView+HHAddition.h"
@implementation UIBarButtonItem (HHAddition)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)hightImage target:(id)target action:(SEL)action{

    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:hightImage] forState:UIControlStateHighlighted];

    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.size = btn.currentBackgroundImage.size;
    
    return [[self alloc]initWithCustomView:btn];
}
+ (instancetype)itemWithtitle:(NSString *)title  target:(id)target action:(SEL)action{

    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.size = btn.currentAttributedTitle.size;
    
    return [[self alloc]initWithCustomView:btn];
}


@end
