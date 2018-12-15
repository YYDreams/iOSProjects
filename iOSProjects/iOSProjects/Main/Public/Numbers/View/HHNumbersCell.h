//
//  HHNumbersCell.h
//  iOSProjects
//
//  Created by funtSui on 2018/12/12.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "BaseCell.h"
#import "FSNumbersModel.h"
@interface HHNumbersCell : BaseCell

// 是否有选玩法类型
@property(nonatomic,assign)BOOL select;

@property(nonatomic,strong)FSNumbersModel *model;

//重置按钮回调
@property(nonatomic,copy)void(^handlerResetBtnCallBack)(void);

@end


@interface FSNumbersPlayView: UIView


//玩法介绍回调
@property(nonatomic,copy)void(^handlerPlayIntroduceBtnCallBack)(void);

//选择玩法类型回调 (类型:直选、组选、直选/组选、迷你) 关心的是有没有选
@property(nonatomic,copy)void (^handlerPlayTypeBtnCallBack)(BOOL select); //


//迷你玩法回调
@property(nonatomic,copy)void (^handlerPlayMiniBtnCallBack)(NSInteger index); //

@end
