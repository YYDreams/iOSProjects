//
//  UIBarButtonItem+HHAddition.h
//  Addition
//
//  Created by 花花 on 2017/1/17.
//  Copyright © 2017年 花花. All rights reserved.
//给UIBarButtonItem

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HHAddition)

/**
 创建导航栏左右两边的按钮(image/hightImage/target/action)

 @param image 默认图片
 @param hightImage 高亮图片
 @param target self
 @param action 响应事件
 @return itrm
 */
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)hightImage target:(id)target action:(SEL)action;


+ (instancetype)itemWithtitle:(NSString *)title  target:(id)target action:(SEL)action;

@end
