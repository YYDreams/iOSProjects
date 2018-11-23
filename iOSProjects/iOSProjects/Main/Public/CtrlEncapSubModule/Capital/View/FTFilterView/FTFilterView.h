//
//  FTFilterView.h
//  Lucky28-TC
//
//  Created by TY.wang on 2017/10/14.
//

#import <UIKit/UIKit.h>

typedef enum {
    FTfilterTypeFromBetRecord,
    FTfilteraFromsearch
} FTfilterType;

@protocol FTFilterViewDelegate <NSObject>

/**
 筛选条件

 @param starDate 开始时间
 @param endDate 结束时间
 @param openState 开奖状态
 @param category 彩种
 */
- (void)filterViewConfirmStarDate:(NSString *)starDate endDate:(NSString *)endDate openState:(NSInteger)openState category:(NSString *)category genre:(NSString *)genre;

@end


@interface FTFilterView : UIView

/**
 是否展示
 */
@property (nonatomic,assign)BOOL isShow;

/**
 代理
 */
@property (nonatomic,weak)id<FTFilterViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame rootview:(UIView *)rootView filterType: (FTfilterType)filterType showCategory:(BOOL)showCategory;

/**
 投注记录筛选
 @param states 订单状态数据源
 */
- (instancetype)initWithFrame:(CGRect)frame rootview:(UIView *)rootView filterType:(FTfilterType)filterType states:(NSArray *)states;

- (void)show;

- (void)close;

/**
 设置筛选状态数组
 
 @param orderStatesDatas 筛选状态数组
 */
- (void)setOrderStatesDatas:(NSArray *)orderStatesDatas;

@end


@interface FTFilterViewHeadView : UICollectionReusableView

/**
 标题
 */
@property (nonatomic,strong)UILabel *label;

@end

@interface FTFilterViewCell : UICollectionViewCell

/**
 标题
 */
@property (nonatomic,strong)UIButton *button;

@end
