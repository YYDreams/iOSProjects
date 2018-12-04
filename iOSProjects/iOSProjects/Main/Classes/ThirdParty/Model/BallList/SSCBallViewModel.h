//
//  SSCBallViewModel.h
//  iOSProjects
//
//  Created by funtSui on 2018/12/4.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSCBallViewModel : NSObject
@property (nonatomic,strong)NSString *commit;//球号，提交订单用
@property (nonatomic,strong)NSString *odds;//赔率
@property (nonatomic,strong)NSString *number;//球号,页面显示使用
@property (nonatomic,strong)NSString *tp;//解释
@property (nonatomic,assign)BOOL isSelect;//是否被选中
@end
