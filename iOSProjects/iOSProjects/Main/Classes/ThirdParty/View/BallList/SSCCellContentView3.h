//
//  SSCCellContentView3.h
//  iOSProjects
//
//  Created by funtSui on 2018/12/5.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSCBallCellModel.h"
@interface SSCCellContentView3 : UIView


@property(nonatomic,strong)SSCBallCellModel *model;

@property(nonatomic,copy)void(^didChangeSelectBall)(NSArray *selectBalls);

+ (CGFloat)getHeight :(SSCBallCellModel *)model;

@end
