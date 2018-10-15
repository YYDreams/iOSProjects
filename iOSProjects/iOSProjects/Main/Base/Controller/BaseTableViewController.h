//
//  BaseTableViewController.h
//  LYGame
//
//  Created by 花花 on 2017/7/15.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "BaseUIViewController.h"

@interface BaseTableViewController : BaseUIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic, strong)NSArray *titles;

@property(nonatomic,strong)NSArray *classNames;


-(UITableView *)tableView;
/***集成头部刷新和底部刷新
 @param tableView 要集成刷新的对象 tableview
 ***/
- (void)setupRefreshTarget:(UITableView*)tableView;

/**
 根据集成类型集成刷新
 @param type 集成的类型
 @param tableView 要集成刷新的对象 tableview
 HHRefreshTypeHeader 只有头
 HHRefreshTypeFooter 只有底部
 HHRefreshTypeHeaderAndFooter 有头也有底部
 */

- (void)setupRefreshTarget:(UITableView*)tableView With:(HHRefreshType)type;
/**
 下拉刷新的回调 子类需要重写
 @param page 当前请求的页数
 */
- (void)pullDownRefresh:(int)page;

/**
 上拉加载跟多的回掉  子类需要重写
 @param page   当前请求的页数
 @param isLastPage yes:已经到了最后一页 NO：还没到
 */
- (void)pullUpRefresh:(int)page lastPage:(BOOL)isLastPage;

//刷新成功的回调方法中调用这个方法 status:0结束头部刷新,1 结束底部刷新;  totalPage: 总页数
- (void)successEndRefreshStatus:(int)status totalPage:(int)totalPage;

//刷新失败的回调方法中调用这个方法 status:0结束头部刷新 1 结束底部刷新
- (void)failEndRefreshStatus:(int)status;


- (void)endRefreshWithNoMoreData;

@end
