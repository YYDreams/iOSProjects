//
//  HHScrollPageViewController.m
//  iOSProjects
//
//  Created by funtSui on 2019/2/13.
//  Copyright © 2019年 flowerflower. All rights reserved.
//

#import "HHScrollPageViewController.h"
#import "HHScrollPageView.h"
@interface HHScrollPageViewController ()

@end

@implementation HHScrollPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * titleArr = @[@"1",@"2",@"3",@"3",@"4"];
    NSArray * controlllersArr = @[@"HHTestViewController",@"HHTestViewController",@"HHTestViewController",@"HHTestViewController",@"HHTestViewController"];

    HHScrollPageView *titleView = [[HHScrollPageView alloc]initWithTitleArray:titleArr controllerClassNameArray:controlllersArr titleNormalColor:[UIColor blackColor] titleSelectedColor:[UIColor redColor] defaultIndex:1 total:5 fatherController:nil];
    titleView.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
    [self.view addSubview:titleView];

}



@end
