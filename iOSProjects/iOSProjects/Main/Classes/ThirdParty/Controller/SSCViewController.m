//
//  SSCViewController.m
//  iOSProjects
//
//  Created by funtSui on 2018/11/28.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "SSCViewController.h"
#import "HHNavTitleView.h"
#import "SSCStructSuperView.h"
#import "SSCStructChildView.h"
#import "SSCStructModel.h"
#import "HHDropDownView.h"
#import "SSCHeaderView.h"
#import "SSCLatestPeriodsView.h"
#import "HHHistoryTableView.h"
@interface SSCViewController ()<SSCStructSuperViewDelegate>
@property(nonatomic,strong)HHNavTitleView *titleView;

@property(nonatomic,strong)SSCStructChildView *structChildView;

@property(nonatomic,strong)SSCStructSuperView *structSuperView;

@property(nonatomic,strong)SSCHeaderView *headerView;


@property(nonatomic,strong)SSCLatestPeriodsView *latestView;


@property(nonatomic,strong)HHHistoryTableView *historyView;


@end

@implementation SSCViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self loadDataFromNetwork];

    [self setupNav];
    
    [self setupSubView];
    

}
#pragma mark - setupNav
- (void)setupNav{
    
    self.view.backgroundColor  = [UIColor whiteColor];
    self.navigationItem.titleView = self.titleView;
}

#pragma mark - setupSubView
- (void)setupSubView{
    
    [self.view addSubview:self.structChildView];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.latestView];
    
    [self.view addSubview:self.historyView];
    

    
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.historyView.top = self.latestView.bottom;

}
#pragma mark - loadDataFromNetwork
- (void)loadDataFromNetwork{
    
    WeakSelf;
    [HTTPRequest GET:kLotteryStructUrl parameter:@{@"lottery_id":@(_model.id)} success:^(id resposeObject) {
       
        if (![resposeObject[@"data"] isKindOfClass:[NSNull class]]) {
            
            SSCStructModel *structModel = [SSCStructModel yy_modelWithDictionary:resposeObject[@"data"]];
            
            [weakSelf.structSuperView setStandardMehtods:structModel.standard fastMethods:structModel.fast];
            
        }
        
        
    } failure:^(NSError *error) {
       
    }];
}

#pragma mark - <SSCStructSuperViewDelegate>
- (void)structSuperView:(SSCStructSuperView *)view didSelectType:(SSCPlayType)type SuperModel:(SSCSuperModel *)model{
    
  [self.titleView setType:(HHNavTitleViewType)type title:model.nm];
    self.structChildView.dataArr = model.child;
    
}


-(void)showHistoryView:(BOOL)show{
    
    
    if (show) {
        
    }else{
        
        
    }
    
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>

#pragma mark - Setter && Getter Methods

-(HHNavTitleView *)titleView{
    if (!_titleView) {
        WeakSelf;
        _titleView = [[HHNavTitleView alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
        
        _titleView.handlerTitleOnClick = ^(BOOL isSelected ) {
            
            NSLog(@"%d------------",isSelected);
            
            weakSelf.titleView.isSelected = !isSelected;
            
            if (isSelected) {
                
                if (weakSelf.structSuperView.superview != self.view) {
                    [weakSelf.structSuperView showInView:weakSelf.view];
                }
                
            }else{
                [weakSelf.structSuperView removeFromSuperview];
                
            }
//            isSelected ?  [weakSelf.structSuperView showInView:weakSelf.view]: [weakSelf.structSuperView removeFromSuperview];
            
            //            !isSelected ?  [weakSelf.dropDownView show]: [weakSelf.dropDownView  close];
            
            
        };
    }
    return _titleView;
    
}

- (SSCStructChildView *)structChildView{
    
    if (!_structChildView) {
        _structChildView = [[SSCStructChildView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 35)];
        _structChildView.lotteryId = [NSString stringWithFormat:@"%ld",_model.id];
        
    }
    return _structChildView;
}

-(SSCHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[SSCHeaderView alloc]initWithFrame:CGRectMake(0, self.structChildView.bottom, self.view.width, 60)];
        _headerView.backgroundColor = [UIColor hh_redomColor];
    }
    return _headerView;
}
-(SSCLatestPeriodsView *)latestView{
    if (!_latestView) {
        _latestView = [[SSCLatestPeriodsView alloc] initWithFrame:CGRectMake(0, self.headerView.bottom, self.view.width, 35)];
        _latestView.backgroundColor = [UIColor hh_redomColor];
        
    }
    return _latestView;
}

-(HHHistoryTableView *)historyView{
    if (!_historyView) {
        _historyView =  [[HHHistoryTableView alloc]initWithFrame:CGRectMake(0, self.latestView.bottom, self.view.bounds.size.width, 200)];
        _historyView.backgroundColor = [UIColor hh_redomColor];
        
    }
    return _historyView;
}



-(SSCStructSuperView *)structSuperView{
    if (!_structSuperView) {
        _structSuperView = [[SSCStructSuperView alloc]initWithFrame:self.view.bounds];
        _structSuperView.lotteryId = [NSString stringWithFormat:@"%ld",_model.id];
        _structSuperView.delegate = self;
        WeakSelf;
        _structSuperView.handlerStructSuperBgCallBack = ^{
          
            weakSelf.titleView.arrowType = SSCArrowType_Down;
        };
        
        
        
    }
    return _structSuperView;
}


@end
