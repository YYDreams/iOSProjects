//
//  SSCCellContentView2.h
//  iOSProjects
//
//  Created by funtSui on 2018/12/5.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSCBallCellModel.h"
@interface SSCCellContentView2 : UIView

@property(nonatomic,strong)SSCBallCellModel *model;


+ (CGFloat)getHeight :(SSCBallCellModel *)model;

@end
