//
//  HHStyleViewModel.h
//  HHTableViewCellStyleDemo
//
//  Created by flowerflower on 2018/7/19.
//  Copyright © 2018年 花花. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,HHCellAccessoryType){
    HHCellAccessoryTypeNone, //类似于UITableViewCellAccessoryNone
    HHCellAccessoryTypeDisclosureIndicator, //右侧是三角箭头(箭头左侧可以有一个image或者一个label，或者二者都有，根据传入的参数决定)
    HHCellAccessoryTypeSwitch, //switch
    HHCellAccessoryTypeLogout, //退出cell
    HHCellAccessoryTypeOther, //自定义类型
    
};

@interface HHStyleViewModel : NSObject

@property(nonatomic,copy) NSString *leftTitle;  //左边name

@property(nonatomic,copy) UIImage  *leftImg;  // 左边图片

@property(nonatomic,copy) NSString *rightSubtitle; //右边的

@property(nonatomic,copy) UIImage *indicatorArrow;  //右边的arrow


@property(nonatomic,copy) NSString *logoutTitle;  // <#注释#>


@property(nonatomic,assign) HHCellAccessoryType  accessoryType;  //accessoryType类型

@property(nonatomic,copy) void(^handlerSwitchValueChangedCallBack)(BOOL isOn); //switch开关回调




/***************************************基本属性设置*************************************/
@property(nonatomic,strong) UIFont *leftTextFont;  // 左侧label文字的字体大小 默认15

@property(nonatomic,strong) UIColor *leftTextColor;  // 左侧label里文字的字体颜色 默认黑色

@property (nonatomic, assign) CGFloat leftImageAndLabelMargin;//左侧image和label的距离，

@property (nonatomic, assign) CGSize indicatorLeftImageSize;                     //右侧尖头左侧image大小，存在默认设置，也可以自定义



@property(nonatomic,strong) UIFont *rightTextFont;  // 右侧label文字的字体大小 默认15


@property(nonatomic,strong) UIFont *righTextColor;









@end
