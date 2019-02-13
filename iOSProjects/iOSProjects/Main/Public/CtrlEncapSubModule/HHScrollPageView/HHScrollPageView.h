//
//  HHScrollPageView.h
//  iOSProjects
//
//  Created by funtSui on 2019/2/13.
//  Copyright © 2019年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHScrollPageView : UIView

- (instancetype)initWithTitleArray:(NSArray *)titleArray
          controllerClassNameArray:(NSArray *)controllerClassNameArray
             titleNormalColor:(UIColor *)titleNormalColor
           titleSelectedColor:(UIColor *)titleSelectedColor
                      defaultIndex:(NSInteger)defaultIndex
                             total:(NSInteger)total
          fatherController:(UIViewController *)fatherController;

@end
