//
//  AppDelegate+UI.m
//  HHToolCategory
//
//  Created by Mac on 2018/8/2.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "AppDelegate+UI.h"
#import "BaseTabBarViewController.h"
@implementation AppDelegate (UI)

- (void)initRootViewControlller{
    
    self.window.rootViewController = [[BaseTabBarViewController alloc]init];

}
@end
