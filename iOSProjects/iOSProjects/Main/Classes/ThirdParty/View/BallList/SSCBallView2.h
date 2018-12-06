//
//  SSCBallView2.h
//  iOSProjects
//
//  Created by funtSui on 2018/12/6.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSCBallViewModel.h"
@interface SSCBallView2 : UIView

@property(nonatomic,strong)SSCBallViewModel *model;

@property(nonatomic,assign)BOOL isSelected;

@property(nonatomic,copy)void (^didChangeStatus)(BOOL isSelected);
@end
