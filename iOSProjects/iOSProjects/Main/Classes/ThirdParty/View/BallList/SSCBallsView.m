//
//  SSCBallsView.m
//  iOSProjects
//
//  Created by funtSui on 2018/12/4.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "SSCBallsView.h"
#import "SSCRandomManager.h"
#import "SSCBallCell.h"
#import "SSCBallViewModel.h"

@interface SSCBallsView()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,assign)UITableViewCellType cellType;//cell类型


@property(nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSArray *dataArray;//数据源


@end

@implementation SSCBallsView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubView];
    }
    return self;
}

-(NSMutableDictionary *)selectBallDict{
    if (!_selectBallDict) {
        _selectBallDict = [[NSMutableDictionary alloc]init];
    }
    return _selectBallDict;
}
- (void)setChildModel:(SSCChildModel *)childModel{
    
    _childModel = childModel;
    
    
    //列表封装数据源
    self.selectBallDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    for(SSCTagsModel *tags in childModel.tags){
        
        SSCBallCellModel *cellModel = [[SSCBallCellModel alloc]init];
        cellModel.title = tags.nm;
        cellModel.isReject = childModel.type.mutex;
        cellModel.max = childModel.type.max;
        cellModel.buy_ball_num = childModel.buy_ball_num;
        cellModel.desc = @"";
        cellModel.min = 1;
        
        NSMutableArray *tempArray2 = [[NSMutableArray alloc]init];
        for(NSInteger i = 0; i < tags.sv.count; i++){
            
            SSCBallViewModel *viewModel = [[SSCBallViewModel alloc]init];
            viewModel.number = [NSString stringWithFormat:@"%@",tags.sv[i]];
            viewModel.isSelect = false;
            if (tags.vv.count > i) {
                viewModel.commit = [NSString stringWithFormat:@"%@",tags.vv[i]];
            }
            else{
                viewModel.commit = @"";
            }
            
            if (tags.odds.count > i) {
                viewModel.odds = [NSString stringWithFormat:@"%.2f",[tags.odds[i] doubleValue]];
            }
            else{
                viewModel.odds = nil;
            }
            
            if (self.childModel.plid.integerValue >= 513 && self.childModel.plid.integerValue <= 515) {
                if (tags.tp.count > i) {
                    if ([tags.tp[i] containsString:@"属相号码："]) {
                        NSMutableString *str = [NSMutableString stringWithString:tags.tp[i]];
                        [str replaceOccurrencesOfString:@"属相号码：" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, tags.tp.count)];
                        viewModel.tp = str;
                    }
                }
            }
            
            [tempArray2 addObject:viewModel];
        }
        cellModel.ballArray = tempArray2;
        [tempArray addObject:cellModel];
    }
    self.dataArray = tempArray;

    
    
    NSLog(@" type ==== %@  cell_type========%ld========",self.childModel.type,self.childModel.type.cell_type.integerValue);
    self.cellType = self.childModel.type ? self.childModel.type.cell_type.integerValue + 1 :UITableViewCell_Type3;

    
    [self.tableView reloadData];
}



- (void)setupSubView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor orangeColor];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self addSubview:tableView];
    self.tableView = tableView;
    
//    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 120)];
//    footerView.backgroundColor = [UIColor whiteColor];
//    tableView.tableFooterView = footerView;
    
    self.backgroundColor = [UIColor clearColor];
    
    
}

//刷新UI
- (void)refreshTableCell{
    //哪些球号已经选择
    for(NSInteger i = 0; i < self.dataArray.count; i++){
        SSCBallCellModel *cellModel = self.dataArray[i];
        NSSet *ballSet = [self.selectBallDict objectForKey:[NSString stringWithFormat:@"%ld",i]];
        //        NSSet *ballSet = [self.selectBallDict objectForKey:cellModel.title];
        for(SSCBallViewModel *viewModel in cellModel.ballArray){
            if ([ballSet containsObject:viewModel.commit]) {
                viewModel.isSelect = true;
            }
            else{
                viewModel.isSelect = false;
            }
        }
        
        SSCBallCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        cell.model = cellModel;
    }
}


#pragma mark - <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.childModel.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellID = [SSCBallCell getCellIdentifier:self.cellType];

    SSCBallCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[SSCBallCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID cellType:self.cellType];
    }
    __weak typeof(self) weakSelf = self;

    __weak SSCBallCell *weakCell = cell;
    cell.model = self.dataArray[indexPath.row];

    cell.didChangeSelectBall = ^(NSArray *selectBalls) {
        [weakSelf ballCell:weakCell didChangeSeletBall:selectBalls];
    };
    cell.indexPath = indexPath;
    
    return cell;
    
    
}
#pragma mark - SSCBallCellDelegate
-(void)ballCell:(SSCBallCell *)cell didChangeSeletBall:(NSArray *)selectArray{
    if (cell.indexPath.row == 0 && cell.model.max > 0 && selectArray.count > cell.model.max) {
        [MBProgressHUD LY_ShowMessage:[NSString stringWithFormat:@"最多只能选择%ld个%@",cell.model.max,cell.model.title]];
        [self.tableView reloadData];
        return;
    }
    if (cell.model.buy_ball_num > 0 && selectArray.count > cell.model.buy_ball_num) {
        [MBProgressHUD showTipMessageInWindow:[NSString stringWithFormat:@"最多只能选择%ld个号码进行投注",cell.model.buy_ball_num]];
        
        [self.tableView reloadData];
        return;
    }
    
    if (selectArray.count > 0) {
        //添加到已经选好的集合
        NSMutableSet *value = [[NSMutableSet alloc] initWithArray:selectArray];
   
        NSString *key = [NSString stringWithFormat:@"%ld",cell.indexPath.row];
        [self.selectBallDict setObject:value forKey:key];
    }
    else{
        //如果没有选中的球，就移除

        NSString *key = [NSString stringWithFormat:@"%ld",cell.indexPath.row];
        [self.selectBallDict removeObjectForKey:key];
    }
    
    //如果所选的球存在互斥关系，那么就移除掉之前的球号
    if (cell.model.isReject == true && selectArray.count > 0) {
        NSArray *keys = self.selectBallDict.allKeys;
        for (NSString *key in keys) {
            if (key.integerValue == cell.indexPath.row) {
                continue;
            }
            //            SSCTagsModel * model = self.childModel.tags[cell.indexPath.row];
            //            if ([key isEqualToString:model.nm]) {
            //                continue;
            //            }
            
            NSMutableSet *set = self.selectBallDict[key];
            for(NSString *number in selectArray){
                if ([set containsObject:number]) {
                    [set removeObject:number];
                }
            }
            if(set.count == 0){
                [self.selectBallDict removeObjectForKey:key];
            }
        }
    }
    
    //刷新列表
    [self refreshTableCell];
    
    //计算注数
//    [self calculateBetCount];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return [SSCBallCell getHight:self.dataArray[indexPath.row] cellType:self.cellType];
    
    
    
}

@end
