//
//  SSCStructSuperView.h
//  iOSProjects
//
//  Created by funtSui on 2018/11/28.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SSCStructModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,SSCPlayType) {
    SSCPlayType_Standard,//标准
    SSCPlayType_Fast,//快捷
};
@class SSCStructSuperView;
@protocol SSCStructSuperViewDelegate <NSObject>

- (void)structSuperView:(SSCStructSuperView *)view didSelectType:(SSCPlayType)type SuperModel:(SSCSuperModel *)model;

@end



@interface SSCStructSuperView : UIView

@property (nonatomic,readonly)SSCSuperModel *superModel;//玩法

@property (nonatomic,weak)id<SSCStructSuperViewDelegate> delegate;//代理

/** item点击回调 */
@property (nonatomic, copy)void (^handlerItemDidSelectCallBack)(SSCPlayType type,SSCSuperModel *model);

/** 空白背景点击 */
@property (nonatomic, copy)void (^handlerStructSuperBgCallBack)(void);


@property(nonatomic,copy) NSString *lotteryId;
- (void)showInView:(UIView *)view;

- (void)close;

//设置数据源
- (void)setStandardMehtods:(NSArray <SSCSuperModel*>*)standardArray fastMethods:(NSArray <SSCSuperModel*>*)fastArray;

@end

NS_ASSUME_NONNULL_END


@interface  SSCPlayMethodButton: UIButton

@property (nonatomic,strong)SSCSuperModel *model;

@property (nonatomic,assign)SSCPlayType type;

@end




