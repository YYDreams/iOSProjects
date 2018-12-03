//
//  HHNavTitleView.h
//  iOSProjects
//
//  Created by funtSui on 2018/11/27.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSCStructModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,SSCArrowType) {
    SSCArrowType_Up,
    SSCArrowType_Down,
};

@interface HHNavTitleView : UIView

/** title */
@property (nonatomic,copy) NSString *title;

/** 字体大小默认15 */
@property (nonatomic,strong) UIFont *font;

/** 字体颜色 默认白色*/
@property (nonatomic,copy) UIColor *textColor;

@property (nonatomic,copy) NSString *arrowImage;


@property (nonatomic,assign)SSCArrowType arrowType;//箭头类型


/** */
@property (nonatomic, assign)BOOL isSelected;


/** titleView的回调*/
@property (nonatomic,copy)void(^handlerTitleOnClick)(BOOL isSelected);

- (void)setType:(HHNavTitleViewType)type title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
