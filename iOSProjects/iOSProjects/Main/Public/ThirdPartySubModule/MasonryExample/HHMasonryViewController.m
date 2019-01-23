//
//  HHMasonryViewController.m
//  iOSProjects
//
//  Created by funtSui on 2019/1/23.
//  Copyright © 2019年 flowerflower. All rights reserved.
//

#import "HHMasonryViewController.h"


@interface HHMasonryViewController ()

@end

@implementation HHMasonryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubView];

}


- (void)setupSubView{
    
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bgView];
 
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.mas_equalTo(self.view);
        make.height.mas_equalTo(60 * kRate);
    }];
    
    NSMutableArray *btns = [NSMutableArray array];
    NSArray *titles = @[@"哈哈",@"呵呵",@"嘿嘿"];
    for (int i = 0 ; i < titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];

        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor hh_redomColor];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [bgView addSubview:btn];

        [btns addObject:btn];
    }


    [btns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(bgView);
    }];
    [btns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:0 tailSpacing:0];

    
    
    

}

@end
