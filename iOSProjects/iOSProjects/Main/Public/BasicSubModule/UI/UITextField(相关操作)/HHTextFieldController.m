//
//  HHTextFieldController.m
//  iOSProjects
//
//  Created by flowerflower on 2018/8/23.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHTextFieldController.h"

#import "HHBoxTextField.h"
@interface HHTextFieldController ()

@end

@implementation HHTextFieldController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(print) name:@"text" object:nil];

    /***
     UITextField  输入支付密码
     UITxtField 输入限制
     
     
     */
    
    [self setupPayPwd];
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self test];
}

- (void)test{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"text" object:nil];
    
    
}
- (void)XXXX{
    
}
- (void)print{
    
    NSLog(@"--------%@",[NSThread currentThread]);
}

- (void)setupPayPwd{
    HHBoxTextField *boxTextField =  [[HHBoxTextField alloc] initWithFrame:CGRectMake(10.0, 50, 45 * 6 + 10 * 6, 45)];

    boxTextField.centerX = self.view.centerX;
    [boxTextField boxInput:6 textEntry:YES editDone:^(NSString *text) {}];
    
    boxTextField.handlerConfirmTextCallBack = ^(NSString *text) {

        NSLog(@"%@",text);
    };
    
    boxTextField.keyboardType = UIKeyboardTypeNumberPad;
    boxTextField.textCornRadius = 5.0;
    
    [self.view addSubview:boxTextField];
    
}

#pragma mark - setupNav



#pragma mark - setupTableView

#pragma mark - loadDataFromNetwork

#pragma mark - <UITableViewDataSource,UITableViewDelegate>

#pragma mark - SEL Method

#pragma mark - Custom Method

#pragma mark - Setter && Getter Methods

@end
