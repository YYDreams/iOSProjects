//
//  Test2ViewController.m
//  iOSProjects
//
//  Created by funtSui on 2018/12/12.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "Test2ViewController.h"
#import "HHNumbersController.h"
@interface Test2ViewController ()

@end

@implementation Test2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *btn =[UIButton buttontitle:@"点我" frame:CGRectMake(150, 200, 100, 40) target:self action:@selector(btnOnClick)];

    btn.backgroundColor = [UIColor hh_redomColor];
    [self.view addSubview:btn];
    

}

- (void)btnOnClick{
    
    
    [self.navigationController pushViewController:[[HHNumbersController alloc]init] animated:true];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
