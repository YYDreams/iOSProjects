//
//  HHLoginView.h
//  iOSProjects
//
//  Created by flowerflower on 2018/8/20.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHLoginView : UIView

@property(nonatomic,strong) UITextField *userName;  //
//登录按钮回调
@property(nonatomic,copy)void(^handlerLoginBtnCallBack)(void);
@end


@interface LoginBtnView: UIView


@property(nonatomic,copy)void(^handlerLoginBtnViewCallBack)(void);

@end
