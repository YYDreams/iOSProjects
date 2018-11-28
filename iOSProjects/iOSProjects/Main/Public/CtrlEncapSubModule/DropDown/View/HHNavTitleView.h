//
//  HHNavTitleView.h
//  iOSProjects
//
//  Created by funtSui on 2018/11/27.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,HHNavTitleViewType){
    
    HHNavTitleViewTypeNormal, //默认 （不显示标准和快捷）
    HHNavTitleViewTypePlayFast, //标准
    HHNavTitleViewTypePlayStandard, //快捷
    
};
@interface HHNavTitleView : UIView

/** title */
@property (nonatomic,copy) NSString *title;

/** 字体大小默认15 */
@property (nonatomic,strong) UIFont *font;

/** 字体颜色 默认白色*/
@property (nonatomic,copy) UIColor *textColor;

/** accow的图片名称*/
@property (nonatomic, copy)NSString *arrowImage;

/** */
@property (nonatomic, assign)BOOL isSelected;


/** titleView的回调*/
@property (nonatomic,copy)void(^handlerTitleOnClick)(BOOL isSelected);

- (void)setType:(HHNavTitleViewType)type title:(NSString *)title;

//- (instancetype)initWithFrame:(CGRect)frame type:(HHNavTitleViewType)type title:(NSString *)title 
@end

NS_ASSUME_NONNULL_END
