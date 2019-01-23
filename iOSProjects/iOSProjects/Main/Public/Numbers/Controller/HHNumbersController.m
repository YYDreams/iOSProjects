//
//  HHNumbersController.m
//  iOSProjects
//
//  Created by funtSui on 2018/12/12.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHNumbersController.h"
#import "HHNumbersCell.h"
#import "HHNumbersBottomView.h"
#import "FSNumbersModel.h"
@interface HHNumbersController ()

@property(nonatomic,strong)UIView *headerView;


@property(nonatomic,strong)UIView *footerView;

@property(nonatomic,strong)HHNumbersBottomView *bottomView;

@property(nonatomic,strong)NSMutableArray *dataArr;

@property(nonatomic,strong)HHNumbersCell *cell;


@end
static NSString *const HHNumbersCellID = @"HHNumbersCellID";

@implementation HHNumbersController


#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubView];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resetNotification) name:@"kResetNotification" object:nil];

}
- (void)resetNotification{
    
    [self.tableView reloadData];
}

#pragma mark - setupNav

#pragma mark - setupSubView

- (void)setupSubView{
    
    
    
    self.tableView.tableHeaderView = self.headerView;
    
    self.tableView.tableFooterView = self.footerView;
    
    [self.tableView registerClass:[HHNumbersCell class] forCellReuseIdentifier:HHNumbersCellID];
    
    [self.view addSubview:self.bottomView];
    
    [self.bottomView setupPrice:10 withStakesNum:4 totalMoney:100];
    
    
    NSLog(@"%f-------",self.tableView.bottom);
    
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.tableView.bottom = self.view.bottom - 60;

    NSLog(@"%f---viewWillLayoutSubviews----",self.tableView.bottom);
}

#pragma mark - loadDataFromNetwork

#pragma mark - <UITableViewDataSource,UITableViewDelegate>


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HHNumbersCell *cell = [tableView dequeueReusableCellWithIdentifier:HHNumbersCellID];
    
    
    NSDictionary *info = @{@"kIndexKey": @(indexPath.row)};

    cell.handlerResetBtnCallBack = ^{
    
        [[NSNotificationCenter defaultCenter]postNotificationName:@"kResetNotification" object:nil userInfo:info];

    };
    
    _cell = cell;
    
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 250 + 45 + 45 *3 + 90;
}

#pragma mark - SEL Methods

- (void)addBtnOnClick{
    
    
    [self.dataArr addObject:@"1"];
    
    
    [self.tableView reloadData];
    
    
    
}
- (void)confirmBtnOnClick{
    

    NSLog(@"%d=====confirmBtnOnClick====",_cell.select);
    
}

#pragma mark - Setter && Getter Methods
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 60)];
        _headerView.backgroundColor = [UIColor hh_redomColor];
    }
    return _headerView;
    
}
- (UIView *)footerView{
    
    if (!_footerView) {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 60)];
        
       UIButton * _footerButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, Screen_Width -2 * 10, 45)];
        [_footerButton setTitle:@"添加新注单" forState:UIControlStateNormal];
        _footerButton.backgroundColor = [UIColor orangeColor];
        [_footerButton addTarget:self action:@selector(addBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:_footerButton];
    }
    return _footerView;
    
}
- (HHNumbersBottomView *)bottomView{
    
    if (!_bottomView) {
        _bottomView = [[HHNumbersBottomView alloc]initWithFrame:CGRectMake(0, Screen_Height - kNavHeight - 60, Screen_Width, 60)];
        WeakSelf;
        _bottomView.handlerConfirmBtnCallBack = ^(UIButton *btn) {
            [weakSelf confirmBtnOnClick];
        };
    }
    return _bottomView;
    
}


- (NSMutableArray *)dataArr{
    
    if (!_dataArr) {
//        FSNumbersModel *model = [[FSNumbersModel alloc]init];
        
        _dataArr = [NSMutableArray arrayWithObjects:@"", nil];
    }
    return _dataArr;
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

@end
