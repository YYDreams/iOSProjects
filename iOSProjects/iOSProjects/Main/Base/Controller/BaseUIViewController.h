//
//  BaseUIViewController.h
//  JYShop
//
//  Created by 花花 on 2017/9/28.
//  Copyright © 2017年 花花. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BaseUIViewController : UIViewController
// 是否隐藏导航 默认是不隐藏的
@property(nonatomic,assign,getter=isHiddenNavBar) BOOL hiddenNavBar;

//加载网络数据 子类需要重写
- (void)loadDataFromNetwork;

//子类重写 自定义导航栏
- (void)setupNav;

//子类重写
- (void)setupUI;


//网络从无网状态变为有网状态回调这个方法
- (void)autoDoRetryRequest;

//方便子类可以调用
- (void)showLoginVC;

@end

