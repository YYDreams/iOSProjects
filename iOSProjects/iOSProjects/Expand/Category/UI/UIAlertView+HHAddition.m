//
//  UIAlertView+HHAddition.m
//  Addition
//
//  Created by 花花 on 2017/1/17.
//  Copyright © 2017年 花花. All rights reserved.
//
/**
 在既有类中使用关联对象存放自定义数据
 以通“关联对象”机制来把两个对象连接起来。这样我们就可以从某个对象中获取相应的关联对象的值。
 */

#import "UIAlertView+HHAddition.h"
#import <objc/runtime.h>

static char kUIAlertViewBlockAddress;

@implementation UIAlertView (HHAddition)

-(void)showAlertWithHandler:(void(^)(NSInteger))callback{
    
    self.delegate = self;
    //为某个对象设置关联对象的值
    //第一个参数是主对象，第二个参数是键，第三个参数是关联的对象，第四个参数是存储策略:是枚举，定义了内存管理语义
    objc_setAssociatedObject(self, &kUIAlertViewBlockAddress, callback, OBJC_ASSOCIATION_COPY);
    [self show];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    //根据给定的键从某对象中获取相应的关联对象值
    AlertCallBack alertCallBack = objc_getAssociatedObject(self, &kUIAlertViewBlockAddress);
    if (alertCallBack)
    {
        alertCallBack(buttonIndex);
        objc_setAssociatedObject(self, &kUIAlertViewBlockAddress, nil, OBJC_ASSOCIATION_COPY);
    }
}

-(void)clearActionBlock{
    
    
    self.delegate  =nil;
    objc_setAssociatedObject(self, &kUIAlertViewBlockAddress, nil, OBJC_ASSOCIATION_COPY);
}
@end
