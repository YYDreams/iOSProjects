//
//  HHStyleViewModel.m
//  HHTableViewCellStyleDemo
//
//  Created by flowerflower on 2018/7/19.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "HHStyleViewModel.h"

@implementation HHStyleViewModel

- (instancetype)init{
    
    if (self = [super init]) {
        
        _leftTextFont = kFont(10);
        _leftTextColor = k3Color;
        _leftImageAndLabelMargin = margin;
        
//        _cellHeight = 44;
//        _cellID = @"defaultCell";
//        _staticCellType = SJStaticCellTypeSystemAccessoryDisclosureIndicator;//默认是存在三角箭头的cell
//        _isImageFirst = YES;
//
//        //都是默认配置
//        _leftLabelTextFont = SJLeftTitleTextFont;
//        _leftLabelTextColor = SJLeftTitleTextColor;
//        _leftImageSize = CGSizeMake(SJImgWidth, SJImgWidth);
//        _leftImageAndLabelGap = SJLeftMiddleGap;
//        _indicatorLeftLabelTextFont = SJIndicatorLeftTitleTextFont;
//        _indicatorLeftLabelTextColor = SJIndicatorLeftTitleTextColor;
//        _indicatorLeftImageSize = CGSizeMake(SJImgWidth, SJImgWidth);
//        _indicatorLeftImageAndLabelGap = SJRightMiddleGap;
        
        
        
    }
    return self;
    
}
@end
