//
//  UILabel+HHAddition.h
//  LYYGame
//
//  Created by 花花 on 2017/5/12.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (HHAddition)

+ (instancetype)labelText:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor textAlignment:(NSInteger)textAlignment;




/**
 *  x y 坐标  高度不变 改变水平宽度
 */
- (UILabel *)autoSizeHorizontal;

/**
 *  x y 坐标 宽度不变 改变高度
 */
- (UILabel *)autoSizeVertical;

/**
 *  改变句中所有的行间距

 */
- (void)hh_changeLineSpaceWithTextLineSpace:(CGFloat)textLineSpace;


@end
