//
//  HHSinglePickerView.h
//  iOSProjects
//
//  Created by funtSui on 2019/1/24.
//  Copyright © 2019年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 弹出单列数据的取消操作回调 */
typedef void(^HHPickerComponentCancelBlock)(void);
/** 弹出单列数据的确定操作回调 */
typedef void(^HHPickerComponentDoneBlock)(NSInteger selectedIndex,NSString *selectedValue);

typedef void(^HHPickerComponentSelectedBlock)(NSString *selectedValue);


@class HHPickerToolBar;
@interface HHSinglePickerView : UIView

@property (strong, nonatomic) HHPickerToolBar *toolBar;

- (instancetype)initWithToolBarTitle:(NSString *)toolBarTitle withData:(NSArray<NSString *> *)data withDefaultIndex:(NSInteger)defaultIndex  cancelAction:(HHPickerComponentCancelBlock)cancelAction doneAction: (HHPickerComponentDoneBlock)doneAction;

@end
