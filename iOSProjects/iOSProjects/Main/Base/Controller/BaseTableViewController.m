//
//  BaseTableViewController.m
//  LYGame
//
//  Created by 花花 on 2017/7/15.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "BaseTableViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "UITableView+LYRefresh.h"
#import "HHTableView.h"

@interface BaseTableViewController ()
@property (nonatomic, weak)UITableView * targetTableView;
@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = kBgColor;

    
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,Screen_Width,Screen_Height - kNavHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        if ([_tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            if (@available(iOS 11.0, *)) {
                _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
            }
        }
        _tableView.separatorColor = kSeparatedLineColor;
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        //empty
        
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
        self.succeedEmptyStr = @"当前暂无内容~";
        self.succeedEmptyImage = [UIImage imageNamed:@"mine_background"];
        
        [self.view addSubview:_tableView];
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0.01)];
        _tableView.tableFooterView = [UIView new];
        
    }
    
    return _tableView;
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    return 0;
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    return nil;
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
        
    }
    cell.textLabel.text =[NSString stringWithFormat:@"%zd - %@",indexPath.row+1,[self.titles safeObjectAtIndex:indexPath.row]];
    cell.detailTextLabel.text = [self.classNames safeObjectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *className = [self.classNames safeObjectAtIndex:indexPath.row];
    
    
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    
    vc.title = [self.titles safeObjectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
    return;
//    //
//    NSUInteger classNameLength = className.length;
//    NSUInteger storyboardlength = @"_UIStoryboard".length;
//    NSUInteger xiblength = @"_xib".length;
//
//    NSString *suffixClassName;
//
//    if (classNameLength >storyboardlength) {
//        suffixClassName = [className substringFromIndex:classNameLength - storyboardlength];
//    }
//
//
//    if ([suffixClassName isEqualToString:@"_UIStoryboard"]) {
//        className = [className substringToIndex:classNameLength - storyboardlength];
//
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:className bundle:[NSBundle mainBundle]];
//        [self.navigationController pushViewController:[storyboard  instantiateInitialViewController] animated:YES];
//
//    }else if ([[className substringFromIndex:classNameLength - xiblength] isEqualToString:@"_xib"]) {
//
//        className = [className substringToIndex:classNameLength - xiblength];
//
//        UIViewController *vc = [[NSClassFromString(className) alloc]initWithNibName:className bundle:nil];
//        vc.title = [self.titles safeObjectAtIndex:indexPath.row];
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }else {
//
//        UIViewController *vc = [[NSClassFromString(className) alloc] init];
//
//        vc.title = [self.titles safeObjectAtIndex:indexPath.row];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
}


#pragma mark -- fresh
- (void)setupRefreshTarget:(UITableView *)tableView
{
    //设置tableView默认 对象为lybaseviewcontroller的tableview
    if (tableView==nil) tableView = self.tableView;
    
    self.targetTableView = tableView;
    
    [tableView setupRefreshFunctionWith:HHRefreshTypeHeaderAndFooter];
    
    WeakSelf;
    [tableView pullUpRefresh:^(int page, BOOL isLastPage) {
        
        [weakSelf pullUpRefresh:page lastPage:isLastPage];
    }];
    
    [tableView pullDownRefresh:^(int page)
     {
         [weakSelf pullDownRefresh:page];
     }];
}

- (void)setupRefreshTarget:(UITableView *)tableView With:(HHRefreshType)type
{
    //设置tableView默认 对象为lybaseviewcontroller的tableview
    if (tableView==nil) tableView = self.tableView;
    
    self.targetTableView = tableView;
    
    [tableView setupRefreshFunctionWith:type];
    
    WeakSelf;
    if (type == HHRefreshTypeHeader)
    {
        [tableView pullDownRefresh:^(int page)
         {
             [weakSelf pullDownRefresh:page];
         }];
    }
    else if (type==HHRefreshTypeFooter)
    {
        [tableView pullUpRefresh:^(int page, BOOL isLastPage) {
            
            [weakSelf pullUpRefresh:page lastPage:isLastPage];
        }];
    }
    else
    {
        [self setupRefreshTarget:tableView];
    }
}

- (void)pullDownRefresh:(int)page
{
    
}

- (void)pullUpRefresh:(int)page lastPage:(BOOL)isLastPage
{
    
}
//请求成功结束刷新状态
- (void)successEndRefreshStatus:(int)status totalPage:(int)totalPage
{
    [self.targetTableView endRefreshStatus:status totalPage:totalPage];
}
//请求失败结束刷新状态
- (void)failEndRefreshStatus:(int)status
{
    [self.targetTableView endRefreshStatus:status];
}

- (void)endRefreshWithNoMoreData{
    
    [self.targetTableView endRefreshWithNoMoreData];
}




@end
