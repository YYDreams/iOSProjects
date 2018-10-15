//
//  UIAlertView+HHAddition.h
//  Addition
//
//  Created by 花花 on 2017/1/17.
//  Copyright © 2017年 花花. All rights reserved.
//给UIAlertView添加分类

#import <UIKit/UIKit.h>
typedef void(^AlertCallBack)(NSInteger buttonIndex);

@interface UIAlertView (HHAddition)

-(void)showAlertWithHandler:(AlertCallBack)callback;

-(void)clearActionBlock;

@end
