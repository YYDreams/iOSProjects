//
//  JYTextField.h
//  JYFarm
//
//  Created by LOVE on 2017/12/7.
//  Copyright © 2017年 花花. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface HHTextField : UITextField

/** 占位文字颜色  */
@property (nonatomic, strong) UIColor *placeHolderColor;

/** 占位文字字体大小 */
@property (nonatomic, assign) CGFloat placeHolderFontSize;

/** 限制输入长度*/
@property (nonatomic, assign) NSInteger maxLength;

/** 限制输入字符*/
@property(nonatomic, copy)NSString  *limitStr;

@end
