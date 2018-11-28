//
//  HHDropDownView.h
//  iOSProjects
//
//  Created by funtSui on 2018/11/27.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface HHDropDownView : UIView


- (instancetype)initWithFrame:(CGRect)frame rootView:(UIView *)rootView;

- (void)show;

- (void)close;


//设置数据源 dataArr 不显示（ 标准、快捷 ） standardArray:标准  fastArray:快捷

- (void)setdataArr:(NSArray *)dataArr standardArray:(NSArray *)standardArray fastArray:(NSArray *)fastArray;

//- (void)setStandardMehtods:(NSArray *)standardArray fastMethods:(NSArray *)fastArray;
@end




@interface HHDropDownSectionHeaderView : UICollectionReusableView

@property(nonatomic,copy)NSString *title;
@end


@interface HHDropDownCell : UICollectionViewCell
@property (nonatomic, weak)UIButton *button;

@end
