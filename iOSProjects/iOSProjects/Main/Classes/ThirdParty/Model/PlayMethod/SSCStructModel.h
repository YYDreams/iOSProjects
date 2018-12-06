//
//  SSCStructModel.h
//  iOSProjects
//
//  Created by funtSui on 2018/11/28.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "BaseModel.h"


@class SSCSuperModel;
@class SSCChildModel;
@class SSCTagsModel;
@class SSCPlayTypeModel;

@interface SSCStructModel : BaseModel

@property (nonatomic,strong)NSArray<SSCSuperModel*> *standard;
@property (nonatomic,strong)NSArray<SSCSuperModel*> *fast;
@property (nonatomic,strong)NSString *def_plid;//默认玩法id
@property (nonatomic,strong)NSString *struct_ver;//结构版本

//通过plist设置cell类型
-(void)setChildPlayType;
@end

/****************************************************************/

@interface SSCSuperModel : BaseModel

@property (nonatomic,strong)NSArray<SSCChildModel*> *child;

@property (nonatomic,copy)NSString *nm;
@end


/****************************************************************/

@interface SSCChildModel : BaseModel

@property (nonatomic,strong)NSArray<SSCTagsModel*> *tags;
@property (nonatomic,copy)NSString *pltx1;
@property (nonatomic,copy)NSString *nm;
@property (nonatomic,copy)NSString *plid;
@property (nonatomic,strong)NSString *pltx2;
@property (nonatomic,strong)NSArray *odds;
@property (nonatomic,strong)NSString *plid_type;
@property (nonatomic,strong)NSString *max_win;
@property (nonatomic,assign)NSInteger buy_ball_num;
@property (nonatomic,strong)SSCPlayTypeModel *type;//玩法类型

@end

/****************************************************************/

@interface SSCTagsModel : BaseModel


@property (nonatomic,strong)NSArray *tp;
@property (nonatomic,strong)NSArray *odds;
@property (nonatomic,copy)NSString *nm;
@property (nonatomic,strong)NSArray *vv;
@property (nonatomic,strong)NSArray *sv;
@property (nonatomic,assign)NSInteger max;//最多选中的球数
@end


/****************************************************************/
@interface SSCPlayTypeModel : BaseModel

@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *random_method;//随机生成方法
@property (nonatomic,strong)NSString *count_method;//算注方法
@property (nonatomic,strong)NSString *cell_type;//cell类型
@property (nonatomic,assign)BOOL mutex;//是否互斥
@property (nonatomic,assign)NSInteger max;//胆码最大个数

@end







