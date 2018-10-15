//
//  HHStyleCell.h
//  HHTableViewCellStyleDemo
//
//  Created by flowerflower on 2018/7/19.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "BaseCell.h"
#import "HHStyleViewModel.h"
#import <UIKit/UIKit.h>
@interface HHStyleCell : BaseCell


@property(nonatomic,strong) HHStyleViewModel *model;  // <#注释#>


@property(nonatomic,copy) void (^handlerSwitchCallBack)(BOOL isOn);
@end
