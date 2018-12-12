//
//  HHNumbersController.m
//  iOSProjects
//
//  Created by funtSui on 2018/12/12.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHNumbersController.h"
#import "HHNumbersCell.h"
@interface HHNumbersController ()


@property(nonatomic,strong)UIView *headerView;


@property(nonatomic,strong)UIView *footerView;


@property(nonatomic,strong)NSMutableArray *dataArr;

@end
static NSString *const HHNumbersCellID = @"HHNumbersCellID";

@implementation HHNumbersController


#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubView];
    
    
    
}

#pragma mark - setupNav

#pragma mark - setupSubView

- (void)setupSubView{
    
    
    
    self.tableView.tableHeaderView = self.headerView;
    
    self.tableView.tableFooterView = self.footerView;
    
    [self.tableView registerClass:[HHNumbersCell class] forCellReuseIdentifier:HHNumbersCellID];
    
    
    
    
    NSLog(@"%f-------",self.tableView.bottom);
    
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.tableView.bottom = self.view.bottom;

    NSLog(@"%f---viewWillLayoutSubviews----",self.tableView.bottom);
}

#pragma mark - loadDataFromNetwork

#pragma mark - <UITableViewDataSource,UITableViewDelegate>


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HHNumbersCell *cell = [tableView dequeueReusableCellWithIdentifier:HHNumbersCellID];

    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 250;
}

#pragma mark - SEL Methods

- (void)addBtnOnClick{
    
    
    [self.dataArr addObject:@"1"];
    
    
    [self.tableView reloadData];
    
    
    
}
#pragma mark - Setter && Getter Methods
- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 200)];
        _headerView.backgroundColor = [UIColor hh_redomColor];
    }
    return _headerView;
    
}
- (UIView *)footerView{
    
    if (!_footerView) {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 45)];
        
       UIButton * _footerButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, Screen_Width -2 * 10, 45)];
        [_footerButton setTitle:@"添加新注单" forState:UIControlStateNormal];
        _footerButton.backgroundColor = [UIColor orangeColor];
        [_footerButton addTarget:self action:@selector(addBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:_footerButton];
    }
    return _footerView;
    
}

- (NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithObjects:@"", nil];
    }
    return _dataArr;
    
}
@end
