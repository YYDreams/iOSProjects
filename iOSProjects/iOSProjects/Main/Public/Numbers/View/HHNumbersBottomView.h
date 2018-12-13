//
//  HHNumbersBottomView.h
//  iOSProjects
//
//  Created by funtSui on 2018/12/13.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHNumbersBottomView : UIView

//确定内容回调
@property(nonatomic,copy)void(^handlerConfirmBtnCallBack)(UIButton *btn);

// price:单价 stakeNum:已选注数  totalMoney:购买总价格
- (void)setupPrice:(NSInteger)price withStakesNum:(NSInteger)stakeNum totalMoney:(NSInteger)totallMoney;
@end
