//
//  HHBoxTextField.h
//  iOSProjects
//
//  Created by flowerflower on 2018/8/23.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHBoxTextField : UITextField


@property(nonatomic,strong) NSString *limitStr;  // 限制字符

@property(nonatomic,strong) UIColor *textBackgroundColor;  // 字符方框背景色 默认白色

@property(nonatomic,assign) CGFloat textCornRadius;  // 字符方框圆角  默认3.0

@property(nonatomic,strong) UIColor *textBordColor;  // //字符方框颜色 默认黑色

@property(nonatomic,strong) UIColor *color;  // 字体颜色

@property(nonatomic,assign) CGFloat fontSize;  // 字体大小 默认15


@property(nonatomic,copy) void (^handlerConfirmTextCallBack)(NSString *text);

- (instancetype)initWithFrame:(CGRect)frame count:(NSInteger)count  textEntry:(BOOL)textEntry editDone:(void(^)(NSString * text))done;

- (void)boxInput:(NSInteger)count textEntry:(BOOL)textEntry editDone:(void(^)(NSString *text))done;

- (void)clearInput;

@end
