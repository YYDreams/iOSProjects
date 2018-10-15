//
//  JYTextField.h
//  JYFarm
//
//  Created by LOVE on 2017/12/7.
//  Copyright © 2017年 花花. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "RMFilterTextField.h"
@interface HHTextField : UITextField
@property(nonatomic,copy)void(^finishCallBack)(void);
@end
