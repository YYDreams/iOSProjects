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

@interface SSCStructSuperView : UIView

@property (nonatomic,readonly)SSCSuperModel *superModel;//玩法

/** item点击回调 */
@property (nonatomic, copy)void (^handlerItemDidSelectCallBack)(SSCPlayType type,SSCSuperModel *model);

- (instancetype)initWithFrame:(CGRect)frame rootView:(UIView *)rootView;

- (void)show;

- (void)close;

//设置数据源
- (void)setStandardMehtods:(NSArray <SSCSuperModel*>*)standardArray fastMethods:(NSArray <SSCSuperModel*>*)fastArray;

@end

NS_ASSUME_NONNULL_END


@interface  SSCPlayMethodButton: UIButton


@end




