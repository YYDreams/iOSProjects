//
//  UITableView+LYRefresh.m
//  LYYGame
//
//  Created by 花花 on 17/3/18.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "UITableView+LYRefresh.h"

#import <MJRefresh/MJRefresh.h>
#import "HHRefreshFactory.h"
@implementation UITableView (LYRefresh)

static void * kpage = (void *)@"currentPage";

static void * kheaderBlock = (void *)@"headerBlock";

static void * kfooterBlock = (void *)@"footerBlock";

static void * kloading = (void *)@"loading";

static void * ktotalPage = (void *)@"total";

#pragma mark -- Property
- (BOOL)isLoading
{
  return ((NSNumber*)objc_getAssociatedObject(self, kloading)).boolValue;
}

- (void)setIsLoading:(BOOL)isLoading
{
  objc_setAssociatedObject(self, kloading, @(isLoading), OBJC_ASSOCIATION_ASSIGN);
}
- (int)currentPage
{
    return ((NSNumber*)objc_getAssociatedObject(self, kpage)).intValue;
}

- (void)setCurrentPage:(int)currentPage
{
    objc_setAssociatedObject(self, kpage, @(currentPage), OBJC_ASSOCIATION_ASSIGN);
}

- (int)totalPage
{
   return ((NSNumber*)objc_getAssociatedObject(self, ktotalPage)).intValue;
}

- (void)setTotalPage:(int)totalPage
{
  objc_setAssociatedObject(self, ktotalPage, @(totalPage), OBJC_ASSOCIATION_ASSIGN);
}
- (headerRefreshBlock)headerRefreshHandle
{
    return objc_getAssociatedObject(self, kheaderBlock);
}
- (void)setHeaderRefreshHandle:(headerRefreshBlock)headerRefreshHandle
{
    objc_setAssociatedObject(self, kheaderBlock, headerRefreshHandle, OBJC_ASSOCIATION_COPY);
}

- (footerRefreshBlock)footerRefreshHandle
{
    return objc_getAssociatedObject(self, kfooterBlock);
}

- (void)setFooterRefreshHandle:(footerRefreshBlock)footerRefreshHandle
{
    objc_setAssociatedObject(self, kfooterBlock, footerRefreshHandle, OBJC_ASSOCIATION_COPY);
}

#pragma mark -- SEL
//set refresh
- (void)setupRefreshFunctionWith:(HHRefreshType)type
{
    self.currentPage = 1;//默认从1开始
    
    if (type == HHRefreshTypeHeader)
    {
        //集成头部刷新
        self.mj_header = [HHRefreshFactory headerRefreshWithTarget:self refreshingAction:@selector(headerRefresh)];
    }
    else if (type==HHRefreshTypeFooter)
    {
        //集成底部刷新
        self.mj_footer = [HHRefreshFactory footerRefreshWithTarget:self refreshingAction:@selector(footerRefresh)];
        self.mj_footer.automaticallyHidden = YES;//没有数据自动隐藏
    }
    else if (type == HHRefreshTypeHeaderAndFooter)
    {
        //集成底部刷新
        self.mj_footer = [HHRefreshFactory footerRefreshWithTarget:self refreshingAction:@selector(footerRefresh)];
        self.mj_footer.automaticallyHidden = YES;
        //集成头部刷新
        self.mj_header = [HHRefreshFactory headerRefreshWithTarget:self refreshingAction:@selector(headerRefresh)];
    }

}
//header
- (void)headerRefresh
{
    if (self.isLoading)
    {
        //如果是正在加载直接结束头部刷新动画
        [self endRefreshStatus:0];
        return;
    }

    self.currentPage = 1;//回复到默认值
    if (self.headerRefreshHandle)
    {
      self.headerRefreshHandle(self.currentPage);
      self.isLoading = YES;
    }
}
//footer
- (void)footerRefresh
{
    if (self.isLoading)
    {
        //如果是正在加载直接结束底部刷新动画
        [self endRefreshStatus:1];
        return;
    }
    
    
    
     NSLog(@"currentPage=%d----totalPage=%d",self.currentPage,self.totalPage);
    //当前页数超过了或者等于最大页数
    if (self.currentPage>=self.totalPage){
        //调用刷新，且最后
        self.footerRefreshHandle(self.currentPage,YES);
        self.isLoading = NO;
        //结束刷新 提示没有更多数据
        [self.mj_footer endRefreshingWithNoMoreData];
        
        return;
    }

    self.currentPage++;
    
    if (self.footerRefreshHandle)
    {
     self.footerRefreshHandle(self.currentPage,NO);
      self.isLoading = YES;
    }
}
//up
- (void)pullUpRefresh:(footerRefreshBlock)block
{
    if (block)
    {
        self.footerRefreshHandle = block;
    }
}
//down
- (void)pullDownRefresh:(headerRefreshBlock)block
{
    if (block)
    {
        self.headerRefreshHandle = block;
    }
}

- (void)endRefreshStatus:(int)status totalPage:(int)totalPage
{
    
    self.totalPage = totalPage;
    self.isLoading = NO;
    
    [self endRefreshStatus:status];
}

- (void)endRefreshStatus:(int)status
{
    self.isLoading = NO;
    
    if (status==0)
    {
        [self.mj_header endRefreshing];
        [self.mj_footer resetNoMoreData];
    }
    else if (status==1)
    {
        [self.mj_footer endRefreshing];
        [self.mj_footer resetNoMoreData];
        
    }
    
}
- (void)endRefreshWithNoMoreData{
    
    [self.mj_footer endRefreshingWithNoMoreData];
    
}
@end
