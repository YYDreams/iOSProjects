//
//  UITextField+Category.m
//  Partner
//
//  Created by 花花 on 2017/4/13.
//  Copyright © 2017年 jackyu. All rights reserved.
//

#import "UITextField+Category.h"

@implementation UITextField (Category)

+ (instancetype)textFieldframe:(CGRect)frame  placeholder:(NSString *)placeholder{


    UITextField *textF = [[UITextField alloc]initWithFrame:frame];
    textF.placeholder = placeholder;
  
    
    [textF setValue:k9Color forKeyPath:@"_placeholderLabel.textColor"];
    textF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    textF.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0,textF.height-1, textF.width, 1)];
    line.backgroundColor= kThemeColor;
    [textF addSubview:line];
    
    [textF setValue:kFont(12) forKeyPath:@"_placeholderLabel.font"];
    textF.font = kFont(14);
    return textF;
}
+ (instancetype)textFplaceholder:(NSString *)placeholder bgColor:(NSString *)bgColor keyboardType:(UIKeyboardType)keyboardType{

    UITextField *textF = [[UITextField alloc]init];
    textF.placeholder = (placeholder);
    textF.keyboardType = keyboardType;
    textF.layer.borderColor= [UIColor whiteColor].CGColor;
    textF.layer.borderWidth= 1.0f;
    kViewRadius(textF, 4);
    textF.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    textF.leftViewMode = UITextFieldViewModeAlways;
    [textF setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

    textF.backgroundColor = [UIColor colorWithHexString:bgColor];
    
    return textF;

}

+ (instancetype)title:(NSString*)title placeholder:(NSString *)placeholder bgColor:(UIColor *)bgColor keyboardType:(UIKeyboardType)keyboardType
{
    UITextField *textF = [[UITextField alloc]init];
    textF.placeholder = placeholder;
    textF.keyboardType = keyboardType;
    textF.layer.borderColor= [UIColor whiteColor].CGColor;
    textF.layer.borderWidth= 1.0f;
    kViewRadius(textF, 4);
    UILabel * left = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 16)];
    left.text = title;
    left.font = kFont(15);
    [left sizeToFit];
    textF.leftView = left;
    textF.leftViewMode = UITextFieldViewModeAlways;
    textF.backgroundColor = bgColor;
    return textF;
}
@end
