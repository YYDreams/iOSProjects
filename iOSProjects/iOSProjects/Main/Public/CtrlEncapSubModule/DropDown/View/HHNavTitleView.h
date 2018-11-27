//
//  HHNavTitleView.h
//  iOSProjects
//
//  Created by funtSui on 2018/11/27.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger,HHNavTitleViewArrowType){
    
    HHNavTitleViewArrowTypeUp,
    HHNavTitleViewArrowTypeDown,
    
};
typedef NS_ENUM(NSInteger,HHNavTitleViewType){
    
    HHNavTitleViewTypeNormal,
    HHNavTitleViewTypePlayFast, //标准
    HHNavTitleViewTypePlayStandard, //快捷
    
};

@interface HHNavTitleView : UIView

/** title */
@property (nonatomic,copy) NSString *title;

/** 是否显示图片 默认为NO*/
@property (nonatomic,assign,getter=isShowImage) BOOL showImage;

@property (nonatomic,copy) UIImage *normalImage;

@property (nonatomic,copy) UIImage *selectedImage;

/** 默认15 */
@property (nonatomic, strong) UIFont *font;

/** 字体颜色 默认白色*/
@property (nonatomic, strong) UIColor *textColor;

@property(nonatomic, strong)UIImageView *imageView; //



@property(nonatomic, assign)HHNavTitleViewArrowType arrowType;

/** titleView的回调*/
@property (nonatomic,copy)void(^handlerTitleOnClick)(HHNavTitleView * titleView);

- (void)show;

- (void)close;



- (void)setType:(HHNavTitleViewType)type title:(NSString *)title;


@end

NS_ASSUME_NONNULL_END
