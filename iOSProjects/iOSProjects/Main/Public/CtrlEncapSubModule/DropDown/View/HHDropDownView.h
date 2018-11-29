//
//  HHDropDownView.h
//  iOSProjects
//
//  Created by funtSui on 2018/11/27.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSCStructModel.h"
#import "HHNavTitleView.h"
@interface HHDropDownView : UIView


@property(nonatomic,copy)void(^handlerDropDownDidSelectCallBack)(HHNavTitleViewType type,SSCSuperModel *model);

- (instancetype)initWithFrame:(CGRect)frame rootView:(UIView *)rootView;

- (void)show;

- (void)close;



//设置数据源 dataArr 不显示（ 标准、快捷 ） standardArray:标准  fastArray:快捷

- (void)setdataArr:(NSArray *)dataArr standardArray:(NSArray *)standardArray fastArray:(NSArray *)fastArray;


//恢复上次的设置
- (void)recoveryLastSuperModel;


@end




@interface HHDropDownSectionHeaderView : UICollectionReusableView

@property(nonatomic,copy)NSString *title;
@end


@interface HHDropDownCell : UICollectionViewCell
@property (nonatomic, weak)UIButton *button;

@end
