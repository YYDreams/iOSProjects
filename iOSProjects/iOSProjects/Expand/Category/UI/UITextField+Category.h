//
//  UITextField+Category.h
//  Partner
//
//  Created by 花花 on 2017/4/13.
//  Copyright © 2017年 jackyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Category)

+ (instancetype)textFieldframe:(CGRect)frame  placeholder:(NSString *)placeholder;

+ (instancetype)textFplaceholder:(NSString *)placeholder bgColor:(NSString *)bgColor keyboardType:(UIKeyboardType)keyboardType;
//
+ (instancetype)title:(NSString*)title placeholder:(NSString *)placeholder bgColor:(UIColor *)bgColor keyboardType:(UIKeyboardType)keyboardType;
@end
