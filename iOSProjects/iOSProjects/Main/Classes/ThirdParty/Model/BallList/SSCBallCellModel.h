//
//  SSCBallCellModel.h
//  iOSProjects
//
//  Created by funtSui on 2018/12/4.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSCBallCellModel : NSObject
@property (nonatomic,strong)NSString *desc;//描述
@property (nonatomic,strong)NSString *title;//名称
@property (nonatomic,strong)NSArray *ballArray;//球数
@property (nonatomic,assign)BOOL isReject;//是否互斥
@property (nonatomic,assign)NSInteger max;//选球最大个数，0是不限制
@property (nonatomic,assign)NSInteger min;//最小球数
@property (nonatomic,assign)NSInteger buy_ball_num;//最大购球数
@end
