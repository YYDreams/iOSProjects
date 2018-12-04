//
//  SSCBallsView.m
//  iOSProjects
//
//  Created by funtSui on 2018/12/4.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "SSCBallsView.h"
#import "SSCRandomManager.h"

@interface SSCBallsView()<UITableViewDelegate,UITableViewDataSource>

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

- (void)setChildModel:(SSCChildModel *)childModel{
    
    _childModel = childModel;
    
    _selectBallDict = [[NSMutableDictionary alloc]init];
}


- (void)refreshTableCell{
    
    
}
- (void)setupSubView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self addSubview:tableView];
    self.tableView = tableView;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 120)];
    footerView.backgroundColor = [UIColor whiteColor];
    tableView.tableFooterView = footerView;
    
    self.backgroundColor = [UIColor clearColor];
    
    
}


#pragma mark - <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.childModel.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil; 
    
}


@end
