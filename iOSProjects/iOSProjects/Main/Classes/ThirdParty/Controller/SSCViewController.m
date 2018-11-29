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

@interface SSCViewController ()
@property(nonatomic,strong)HHNavTitleView *titleView;

@property(nonatomic,strong)SSCStructChildView *structChildView;


@property(nonatomic,strong)SSCStructSuperView *structSuperView;

@property (nonatomic,strong)HHDropDownView *dropDownView;

@end

@implementation SSCViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
 

    [self setupSubView];
    
    [self loadDataFromNetwork];

}



#pragma mark - setupNav

#pragma mark - setupSubView
- (void)setupSubView{
    
    self.view.backgroundColor  = [UIColor whiteColor];
    self.navigationItem.titleView = self.titleView;
    
    [self.view addSubview:self.structChildView];
    
//    [self.view addSubview:self.structSuperView];
    
    [self.view addSubview:self.dropDownView];

    
}
#pragma mark - loadDataFromNetwork
- (void)loadDataFromNetwork{
    
    WeakSelf;
    [HTTPRequest GET:kLotteryStructUrl parameter:@{@"lottery_id":@(_model.id)} success:^(id resposeObject) {
       
        if (![resposeObject[@"data"] isKindOfClass:[NSNull class]]) {
            
            SSCStructModel *structModel = [SSCStructModel yy_modelWithDictionary:resposeObject[@"data"]];
            
            [weakSelf.dropDownView setdataArr:nil standardArray:structModel.standard fastArray:structModel.fast];
            
            [weakSelf.titleView defalutTitleModel:structModel];
 
            weakSelf.dropDownView.handlerDropDownDidSelectCallBack = ^(HHNavTitleViewType type, SSCSuperModel *model) {
                
                [weakSelf.titleView setType:type title:model.nm];
                
                self.structChildView.dataArr = model.child;
                
            };
        }
        
        
    } failure:^(NSError *error) {
       
    }];
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
            !isSelected ?  [weakSelf.dropDownView show]: [weakSelf.dropDownView  close];
            

        };
    }
    return _titleView;
    
}

- (SSCStructChildView *)structChildView{
    
    if (!_structChildView) {
        _structChildView = [[SSCStructChildView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 35)];
    }
    return _structChildView;
}
-(HHDropDownView *)dropDownView{
    if (!_dropDownView) {
        _dropDownView = [[HHDropDownView alloc]initWithFrame:self.view.bounds rootView:self.view];
 
        [self.view addSubview:_dropDownView];
    }
    return _dropDownView;
}

-(SSCStructSuperView *)structSuperView{
    if (!_structSuperView) {
        _structSuperView = [[SSCStructSuperView alloc]initWithFrame:self.view.bounds rootView:self.view];
  
    }
    return _structSuperView;
}





@end
