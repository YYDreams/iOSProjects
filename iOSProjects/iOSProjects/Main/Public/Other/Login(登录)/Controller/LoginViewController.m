//
//  LoginViewController.m
//  iOSProjects
//
//  Created by flowerflower on 2018/8/20.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginHandle.h"
#import "HHLoginView.h"
#import "TestViewController.h"
@interface LoginViewController ()

@property(nonatomic, strong)HHLoginView *loginView ;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setupSubView];
    
    
}
- (void)setupSubView{
    
    WeakSelf;
    [self.view addSubview:self.loginView];
    [self.loginView setHandlerLoginBtnCallBack:^{
        
        [weakSelf loginOnClick];
        
    }];
    
}

- (void)loginOnClick{
    
    
    [HTTPRequest POST:@"5b6685533200006a00ee11b1" parameter:nil success:^(id resposeObject) {
        if (Success) {
            
            UserModel *model = [UserModel objectWithDic:resposeObject[@"data"]];
            model.mobile = _loginView.userName.text;
            [LoginHandle shareInstance].userInfo = model;
            [LoginHandle saveUserInfo:model];
            NSLog(@"%@",UserDataFilePath);
            [self.navigationController pushViewController:[[TestViewController alloc]init] animated:YES];
            
        }
    } failure:^(NSError *error) {
       
    }];
    
}
#pragma mark - Setter && Getter Methods
- (HHLoginView *)loginView{
    
    if (!_loginView) {
        _loginView = [[HHLoginView alloc]initWithFrame:self.view.frame];
        
        
    }
    return _loginView;
}

@end
