//
//  BaseTableViewController+PageStatus.h
//  LYGame
//
//  Created by 花花 on 2017/8/3.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "BaseTableViewController.h"

#import "UIScrollView+EmptyDataSet.h"

typedef NS_ENUM(NSInteger,PageStatus) {
    
    PageStatusLoading,
    PageStatusError,
    PageStatusSucceed
};

typedef void(^EmptyViewTapBlock)(void);

@interface BaseTableViewController (PageStatus)<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
/**
 *  当前页面状态
 */
@property (nonatomic, assign) PageStatus currentPageStatus;

/**
 *  如果请求成功，空数据，显示提示
 */
@property (nonatomic, strong) NSString *succeedEmptyStr;

/**
 *  如果请求成功，空数据，显示的图片
 */
@property (nonatomic ,strong) UIImage *succeedEmptyImage;

/**
 *  空页面点击，刷新block
 */
@property (nonatomic, copy) EmptyViewTapBlock emptyViewTapBlock;


@end
