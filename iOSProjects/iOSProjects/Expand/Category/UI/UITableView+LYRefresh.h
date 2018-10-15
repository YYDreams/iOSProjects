//
//  UITableView+LYRefresh.h
//  LYYGame
//
//  Created by 花花 on 17/3/18.
//  Copyright © 2017年 kevin. All rights reserved.
//

typedef void(^headerRefreshBlock)(int page);

typedef void(^footerRefreshBlock)(int page,BOOL isLastPage);

#import <UIKit/UIKit.h>

@interface UITableView (LYRefresh)
//当前是第几页
@property (nonatomic, assign)int currentPage;
//总共有多少页
@property (nonatomic, assign)int totalPage;

@property (nonatomic, copy)headerRefreshBlock headerRefreshHandle;
@property (nonatomic, copy)footerRefreshBlock footerRefreshHandle;

//是否正在刷新
@property (nonatomic, assign)BOOL isLoading;

//集成下拉刷新上拉加载功能
- (void)setupRefreshFunctionWith:(HHRefreshType)type;

//下拉刷新
- (void)pullDownRefresh:(headerRefreshBlock)block;

//上拉加载
- (void)pullUpRefresh:(footerRefreshBlock)block;

//数据请求回来后结束刷新的回调  totalPage 总页数
- (void)endRefreshStatus:(int)status totalPage:(int)totalPage;

- (void)endRefreshStatus:(int)status;
- (void)endRefreshWithNoMoreData;
@end
