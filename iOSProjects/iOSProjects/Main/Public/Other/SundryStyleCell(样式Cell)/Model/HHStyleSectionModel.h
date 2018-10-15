//
//  HHStyleSectionModel.h
//  HHTableViewCellStyleDemo
//
//  Created by flowerflower on 2018/7/20.
//  Copyright © 2018年 花花. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHStyleSectionModel : NSObject

@property (nonatomic,copy) NSString  *sectionHeaderName; /**< 传空表示分组无名称*/

@property (nonatomic,assign) CGFloat  sectionHeaderHeight; /**<      分组header高度*/

@property (nonatomic,strong) NSArray  *itemArray; /**< item模型数组*/

@property (nonatomic,strong) UIColor  *sectionHeaderBgColor; /**< 背景色*/

@end
