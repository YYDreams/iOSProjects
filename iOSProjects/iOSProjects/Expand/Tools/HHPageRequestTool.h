//
//  HHPageRequestTool.h
//  iOSProjects
//
//  Created by huahua on 2020/8/18.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHPageRequestTool : NSObject

typedef void(^HanderlLoadDataFromNetwork)(NSInteger page,NSInteger count,BOOL isLastPage,UITableView * tableView, HHPageRequestTool *tool);


@property (nonatomic, copy)HanderlLoadDataFromNetwork handler;


@property (nonatomic, strong, readonly)NSMutableArray *dataArr;


@property (nonatomic, assign, readonly)BOOL isLastPage;


//初始化 PageCount:每页条数
- (instancetype)initWithTableView:(UITableView *)tableView PageCount:(NSInteger)pageCount;

//处理返回的具体数据
-(void)dealRefreshWithModelArr:(NSArray *)arr;

//下拉加载最新的数
- (void)refresh;

//上拉加载更多的数据
- (void)loadMore;

//结束刷新
-(void)endRefreshing;

@end

NS_ASSUME_NONNULL_END
