//
//  HHCapitalViewController.m
//  iOSProjects
//
//  Created by funtSui on 2018/11/22.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHCapitalViewController.h"
#import "FTFilterView.h"
@interface HHCapitalViewController ()<FTFilterViewDelegate>

@property(nonatomic, strong)FTFilterView *filterView;

@property(nonatomic, strong)NSMutableArray *dataArr;

@property(nonatomic, strong)NSMutableDictionary  *params;

@property (nonatomic, strong) NSMutableArray *allChildren;

@end

@implementation HHCapitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setupNav];
    
    [self setupRefresh];
    
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self loadDataFromNetwork];

}

- (void)setupNav{
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back" highImage:@"navigationbar_back" target:self action:@selector(navRightOnClick)];
    
    
}
- (void)setupRefresh{
    
   
    
}



- (void)loadDataFromNetwork{
    

    
    
//https://www-api2.tctest2.com/v2/block/condition/capital?type=2
    [HTTPRequest GET:kCapitalUrl parameter:@{@"type":@"2"} success:^(id resposeObject) {
        
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dic  in resposeObject[@"data"]) {
            
            [tempArr addObject:dic];
            
        }
        
        
        for (int i = 0 ; i < tempArr.count; i++) {
            
            for (NSDictionary  *dic in tempArr[i][@"children"]) {
                [self.allChildren addObject:dic];
            }
        }
        
        [self.allChildren insertObject:@{@"id": @"0",@"name":@"全部"} atIndex:0];
        
        [tempArr insertObject:@{@"id": @"0",@"name":@"全部",@"children":@[@{@"id": @"0",@"name":@"全部"}]} atIndex:0];
        
        
        NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        
        documentPath = [documentPath stringByAppendingString:@"/capital.json"];
        
        NSFileManager *manager = [NSFileManager defaultManager];
        NSData *data = [tempArr yy_modelToJSONData];
        [manager createFileAtPath:documentPath contents:data attributes:nil];
    } failure:^(NSError *error) {
        
    }];
    
    
    
}

- (void)navRightOnClick{
    
    self.filterView.isShow ? [self.filterView  close] : [self.filterView show];
    
}

- (void)filterViewConfirmStarDate:(NSDate *)starDate endDate:(NSDate *)endDate openState:(NSInteger )openState category:(NSString *)category genre:(NSString *)genre{
    
    
}
-(FTFilterView *)filterView {
    if (!_filterView) {
        _filterView = [[FTFilterView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width - 150, Screen_Height - 44 - [UIApplication sharedApplication].statusBarFrame.size.height) rootview:self.view filterType:FTfilteraFromsearch showCategory:YES];
        _filterView.delegate = self;
    }
    return _filterView;
}


- (NSMutableDictionary *)params{
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
    
}
- (NSMutableArray *)allChildren{
    if (!_allChildren) {
        _allChildren = [NSMutableArray array];
    }
    
    return _allChildren;
    
}

















@end
