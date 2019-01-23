//
//  BaseTabBarViewController.m
//  JYShop
//
//  Created by 花花 on 2017/9/28.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseUIViewController.h"
#import "BaseNavViewController.h"
@interface BaseTabBarViewController ()

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupControllers];
    
    

}

- (void)setupControllers{
    //控制器的名字HomeViewController  TestViewController  FTBuyLotteryLobbyViewController  Test2ViewController
    //BasicViewController 基础知识  ThirdPartyViewController 第三方
    NSArray *ControllerViews = @[@"HHTextFieldController",@"CtrlEncapViewController",@"ThirdPartyViewController",@"HomeViewController",@"MoreViewController"];
    //TabBar图片
    NSArray *normalImageNames = @[@"home_nav_home_click", @"home_nav_farm_click", @"home_nav_bazaar_click", @"home_nav_treasure_click",@"home_nav_kits_click"];
    //TabBar选中的图片
    NSArray *selectImageNames = @[@"home_nav_home", @"home_nav_farm", @"home_nav_bazaar",@"home_nav_treasure", @"home_nav_kits"];
    
    //TabBarItem标题
//    NSArray *titles = @[@"基础知识",@"控件封装",@"第三方",@"须知知识",@"更多"];
    NSArray *titles = @[@"111",@"222",@"333",@"444",@"More"];
    
    
    for (int i = 0; i< ControllerViews.count; i++)
    {
        //1.获取类名字符串
        NSString *className= ControllerViews[i];
        //2。获取类名
        Class class = NSClassFromString(className);
        //3.创建对象
        BaseUIViewController * viewController  = [[class alloc] init];
        viewController.title = titles[i];
        self.tabBar.tintColor = k3Color;
        self.tabBar.translucent = NO;
        viewController.tabBarItem.image = [[UIImage imageNamed:normalImageNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.tabBarItem.selectedImage =  [[UIImage imageNamed:selectImageNames[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        BaseNavViewController *nav = [[BaseNavViewController alloc]initWithRootViewController:viewController];
        [self addChildViewController:nav];
        
        
    }
    //默认选中第一个
    self.selectedIndex = 2;
    
    
    
}



@end
