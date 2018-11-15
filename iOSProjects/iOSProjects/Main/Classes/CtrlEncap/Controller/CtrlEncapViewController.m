
//
//  CtrlEncapViewController.m
//  iOSProjects
//
//  Created by flowerflower on 2018/8/20.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "CtrlEncapViewController.h"
#import "HHLotteryListCell.h"
#import "HHLotteryListModel.h"
@interface CtrlEncapViewController ()

/** <#注释#> */
@property (nonatomic, strong) NSMutableArray *dataArr;
@end
static NSString *const HHLotteryListCellID = @"HHLotteryListCell";

@implementation CtrlEncapViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupRefresh];
    
}
#pragma mark - setupNav
#pragma mark - setupTableView
- (void)setupTableView{
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HHLotteryListCell" bundle:nil] forCellReuseIdentifier:HHLotteryListCellID];
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)setupRefresh{
    
    [self setupRefreshTarget:nil];
    
    [self loadListDatilWithPageNo:1 andStatus:3];
}


#pragma mark - loadDataFromNetwork
- (void)loadListDatilWithPageNo:(int)pageNo andStatus:(int)status{
    
    WeakSelf;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"page"] = @(pageNo);
    param[@"page_size"] = @(20);
    
    [HTTPRequest GET:kLotteryUrl parameter:param success:^(id resposeObject) {  //农庄认养
        
        if ([resposeObject[@"data"] isKindOfClass:[NSArray class]] && ![resposeObject[@"data"] isEqual:[NSNull class]]) {

            NSArray *dataArr = [HHLotteryListModel objectsInArray:resposeObject[@"data"]];
            [self.dataArr addObjectsFromArray:dataArr];
            
//            int totalPage = [resposeObject[@"data"][@"pages"] intValue];
//
            [weakSelf successEndRefreshStatus:status totalPage:dataArr.count];
//
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (self.dataArr.count >0 && self.dataArr.count<20) {
                    
                    [weakSelf endRefreshWithNoMoreData];
                }
                
                [weakSelf.tableView reloadData];
                
            });
            
        }else{
            [MBProgressHUD LY_ShowError:resposeObject[@"msg"] time:2];
            [weakSelf failEndRefreshStatus:status];
            
        }
        self.currentPageStatus = PageStatusSucceed;
    } failure:^(NSError *error) {
        [weakSelf failEndRefreshStatus:status];
        [MBProgressHUD LY_ShowError:kNoNetworkTips time:2.0];
        self.currentPageStatus = PageStatusError;
        self.emptyViewTapBlock = ^{
            [weakSelf pullDownRefresh:1];
        };
    }];
    
}
- (void)pullDownRefresh:(int)page{
    
    [self.dataArr  removeAllObjects];
    //0 结束头部
    [self loadListDatilWithPageNo:page andStatus:0];
    
}
- (void)pullUpRefresh:(int)page lastPage:(BOOL)isLastPage{
    
    if (isLastPage) {
        return;
    }
    [self loadListDatilWithPageNo:page andStatus:1];
    
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 11;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HHLotteryListCell *cell = [tableView dequeueReusableCellWithIdentifier:HHLotteryListCellID forIndexPath:indexPath];
    
    
    cell.model = [self.dataArr safeObjectAtIndex:indexPath.row];
    
    return cell;
    
    
}
#pragma mark - Setter && Getter Methods
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
   }
    return _dataArr;
}




@end
