//
//  FTLottertCategory.h
//  iOSProjects
//
//  Created by funtSui on 2018/11/28.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FTLottertCategory : BaseModel

@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , assign) NSInteger              pid;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * alias;
@property (nonatomic , assign) NSInteger              sort;
@property (nonatomic , copy) NSString              * buy_f_img;
@property (nonatomic , copy) NSString              * buy_c_img;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , copy) NSString              * state;

@end

NS_ASSUME_NONNULL_END
