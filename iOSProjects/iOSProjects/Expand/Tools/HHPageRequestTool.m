//
//  HHPageRequestTool.m
//  iOSProjects
//
//  Created by huahua on 2020/8/18.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "HHPageRequestTool.h"

@interface HHPageRequestTool()


@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong, readwrite)NSMutableArray *dataArr;

//分页查询使用
@property (nonatomic, assign)NSInteger page;


@property (nonatomic, assign)NSInteger count;


@property (nonatomic, assign, readwrite)BOOL isLastPage;

@end

@implementation HHPageRequestTool

//初始化 PageCount:每页条数
- (instancetype)initWithTableView:(UITableView *)tableView PageCount:(NSInteger)pageCount{
    
    if (self = [super init]) {
        
        self.tableView = tableView;
        self.page = 1;
        self.count = pageCount;
        
        [self commonInit];
        
        
    }
    return self;
    
}
- (void)commonInit{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf refresh];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_header endRefreshing];
        });
    }];
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf loadMore];
    }];
    [self.tableView.mj_header beginRefreshing];
    
}


//处理返回的具体数据
-(void)dealRefreshWithModelArr:(NSArray *)arr{
    
    if (self.page == 1) {
        self.dataArr = [NSMutableArray arrayWithArray:arr];
    }else{
        [self.dataArr addObjectsFromArray:arr];
    }
    [self.tableView reloadData];
    
    if (arr.count < self.count) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        self.tableView.mj_footer.hidden =  (arr.count> 0 )? NO : YES;
    }else{
        [self endRefreshing];
    }
    
    self.isLastPage = [arr isKindOfClass:NSArray.class] ? arr.count < 20 : YES;

    
    
}

//下拉加载最新的数
- (void)refresh{
    
    self.page  = 1;
    self.dataArr = [NSMutableArray array];
    [self.tableView.mj_footer resetNoMoreData];
    self.handler(self.page, self.count,self.isLastPage, self.tableView, self);

    
}

//上拉加载更多的数据
- (void)loadMore{
    
    self.page++ ;
    
    self.handler(self.page, self.count,self.isLastPage, self.tableView, self);
    
}

//结束刷新
-(void)endRefreshing{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
}

@end
