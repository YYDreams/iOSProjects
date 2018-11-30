
//
//  HHHistoryTableView.m
//  iOSProjects
//
//  Created by funtSui on 2018/11/30.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHHistoryTableView.h"
#import "HHHistoryTableViewCell.h"
@interface HHHistoryTableView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *dataArr;


@property(nonatomic,assign)LotteryHistoryTableType type;
@end

@implementation HHHistoryTableView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubView];
    }
    return self;
    
}
- (void)setupSubView{
    
    [self addSubview:self.tableView];

}

- (void)setLotteryHistoryTableType:(LotteryHistoryTableType)type dataArr:(NSArray *)dataArr{
    
    if (dataArr.count == 0) {return;}
    
    _type = type;
    
    _dataArr = dataArr;
    
    [self.tableView reloadData];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count > 5 ? 5 : self.dataArr.count;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HHHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HHHistoryTableViewCellID"];
    
    
    
    return cell;
    
}








- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[HHHistoryTableViewCell class] forCellReuseIdentifier:@"HHHistoryTableViewCellID"];
        
        _tableView = tableView;
    }
    return _tableView;
    
}
@end
