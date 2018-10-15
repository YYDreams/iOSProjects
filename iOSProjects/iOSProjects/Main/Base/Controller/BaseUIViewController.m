//
//  BaseUIViewController.m
//  JYShop
//
//  Created by 花花 on 2017/9/28.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "BaseUIViewController.h"
#import "BaseNavViewController.h"
@interface BaseUIViewController (){
    
    NSInteger isPacket;
    
}

@end

@implementation BaseUIViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBgColor;
    

    
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏导航栏
    if (self.isHiddenNavBar==YES)
    {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //显示导航栏
    if (self.isHiddenNavBar==YES)
    {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
    
}

//显示登录界面
- (void)showLoginVC{
    
    

}

#pragma mark - loadData

//加载网络数据 子类需要重写
- (void)loadDataFromNetwork{
    
    
}
#pragma mark - setupUI

//子类重写 自定义导航栏
- (void)setupNav{
    
    
}

//子类重写
- (void)setupUI{
    
}

//网络从无网状态变为有网状态回调这个方法
- (void)autoDoRetryRequest
{
    
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

@end
