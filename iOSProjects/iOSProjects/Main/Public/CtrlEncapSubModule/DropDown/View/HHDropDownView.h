//
//  HHDropDownView.h
//  iOSProjects
//
//  Created by funtSui on 2018/11/27.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHDropDownView : UIView



/** 是否展示 */
@property (nonatomic,assign)BOOL isShow;


- (instancetype)initWithFrame:(CGRect)frame rootView:(UIView *)rootView showCategory:(BOOL)showCategory;

- (void)show;

- (void)close;


@end

NS_ASSUME_NONNULL_END
