//
//  SSCBallView1.h
//  iOSProjects
//
//  Created by funtSui on 2018/12/5.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSCBallViewModel.h"
@interface SSCBallView1 : UIView



@property(nonatomic,assign)BOOL isSelect;

@property(nonatomic,strong)SSCBallViewModel *model;


@property (nonatomic,strong)void (^didChangeStatus)(BOOL isSelect);//改变选中状态


@end
