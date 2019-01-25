//
//  HHPickerToolBar.h
//  iOSProjects
//
//  Created by funtSui on 2019/1/24.
//  Copyright © 2019年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BtnAction)(void);

@interface HHPickerToolBar : UIView

/** 标题 默认为空 */
@property(nonatomic,copy) NSString  *title;

/** 字体大小 默认15 */
@property(nonatomic,strong) UIFont   *font;

/** 字体颜色 默认黑色 */
@property(nonatomic,strong) UIColor  *titleColor;

- (instancetype)initWithToolbarTitle:(nullable NSString *)toolBarTitle cancelAction:(BtnAction)cancelAction doneAction:(BtnAction)doneAction;
@end
