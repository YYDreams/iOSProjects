//
//  HHPickerComponent.h
//  iOSProjects
//
//  Created by funtSui on 2019/1/24.
//  Copyright © 2019年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHPickerToolBar.h"
#import "HHSinglePickerView.h"

@interface HHPickerComponent : UIView


@property(nonatomic,strong)HHPickerToolBar *toolBar;
/**
 *  弹出显示单列数据的pickerView
 *
 *  @param toolBarTitle   提示文字
 *  @param data          数据 -- 数组(字符串)
 *  @param defaultIndex  默认选中index
 *  @param cancelHandler 取消操作
 *  @param doneHandler   完成操作
 */
+ (HHPickerComponent *)showSinglePickerWithToolBarTitle:(NSString *)toolBarTitle withData:(NSArray<NSString *> *)data withDefaultIndex:(NSInteger)defaultIndex cancelHandler:(HHPickerComponentCancelBlock)cancelHandler withDoneHandler:(HHPickerComponentDoneBlock)doneHandler;

@end
