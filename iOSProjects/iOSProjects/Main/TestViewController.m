//
//  TestViewController.m
//  iOSProjects
//
//  Created by flowerflower on 2018/8/20.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "TestViewController.h"
#import "HHWeChatFloatingBtn.h"

#import "HHLotteryListCell.h"
#import "HHLotteryListModel.h"
#import "HHDBManager.h"
#import "HHBannerModel.h"
#import "HHDorpDownController.h"
#import "HHCapitalViewController.h"

@interface TestViewController ()
@property (nonatomic, strong) NSArray *dataArr;

@end
static NSString *const HHLotteryListCellID = @"HHLotteryListCell";

@implementation TestViewController

- (void)navRightOnClick{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"添加浮窗" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *defalutAction = [UIAlertAction actionWithTitle:@"添加浮窗" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action
                                                                                                                    ) {
        [HHWeChatFloatingBtn show];
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVc addAction:defalutAction];
    [alertVc addAction:cancelAction];
    
    [self presentViewController:alertVc animated:YES completion:nil];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"浮窗" style:0 target:self action:@selector(navRightOnClick)];
    
    
    [self setupTableView];
    
    [self setupRefresh];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    
}
#pragma mark - setupTableView
- (void)setupTableView{
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HHLotteryListCell" bundle:nil] forCellReuseIdentifier:HHLotteryListCellID];
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)setupRefresh{
    
    [self loadCacheData];
    
    
    [self setupRefreshTarget:nil];
    
    [self loadListDatilWithPageNo:1 andStatus:3];
    
}

- (void)loadCacheData{
    
    HHDBManager *manager = [[HHDBManager alloc]initWithobjectClass:[HHLotteryListModel class]];
    NSArray *cacheData = [manager getAllObjects];
    if (cacheData > 0 ) {
        self.dataArr = cacheData;
        [self.tableView reloadData];
        
    }
}

- (void)saveLotteryCache:(NSArray *)lotterys{
    
    HHDBManager *manager = [[HHDBManager alloc]initWithobjectClass:[HHLotteryListModel class]];
    
    [manager insertObjects:lotterys];
    
}

#pragma mark - loadDataFromNetwork
- (void)loadListDatilWithPageNo:(int)pageNo andStatus:(int)status{
    
    WeakSelf;
    NSString *page_size = @"20";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"page"] = @(pageNo);
    param[@"page_size"] = page_size?:@"";
    
    //@"v2/block/home/app/banner"
    [HTTPRequest GET:kLotteryUrl parameter:param success:^(id resposeObject) {  //
        
        if ([resposeObject[@"data"] isKindOfClass:[NSArray class]] && ![resposeObject[@"data"] isEqual:[NSNull class]]) {
            
            NSArray *dataArr = [HHLotteryListModel objectsInArray:resposeObject[@"data"]];
            //            [self.dataArr addObjectsFromArray:dataArr];
            self.dataArr = dataArr;
            //            int totalPage = [resposeObject[@"data"][@"pages"] intValue];
            //
            [weakSelf successEndRefreshStatus:status totalPage:(int)dataArr.count];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (self.dataArr.count >0 && self.dataArr.count<20) {
                    
                    [weakSelf endRefreshWithNoMoreData];
                }
                if (dataArr.count >0) {
                    [weakSelf.tableView reloadData];
                    
                    [weakSelf saveLotteryCache:dataArr];
                }
                
                
                
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
    
    //    [self.dataArr  removeAllObjects];
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
    
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HHLotteryListCell *cell = [tableView dequeueReusableCellWithIdentifier:HHLotteryListCellID forIndexPath:indexPath];
    
    
    cell.model = [self.dataArr safeObjectAtIndex:indexPath.row];
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [self.navigationController pushViewController:[HHDorpDownController new] animated:YES];
    
}
#pragma mark - Setter && Getter Methods
//- (NSMutableArray *)dataArr{
//    if (!_dataArr) {
//        _dataArr = [NSMutableArray array];
//   }
//    return _dataArr;
//}



- (void)test1{
    
    
    
    //1.创建队列组
    dispatch_group_t group = dispatch_group_create();
    //2.获取全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);

    //3.往队列中添加耗时操作
    dispatch_group_async(group, queue, ^{
       
        //执行耗时的异步操作1
        NSLog(@"/执行耗时的异步操作1");
    });
    
    dispatch_group_async(group, queue, ^{
       
        NSLog(@"/执行耗时的异步操作2");
    });
    
    //当并发队列组中的任务执行完毕才能执行这里
    dispatch_group_notify(group, queue, ^{
        
        //回归主线程
        dispatch_group_async(group, dispatch_get_main_queue(), ^{
           
            NSLog(@"跟新UI");
        });
    });
}

- (void)test2{
    
    
    dispatch_queue_t queue = dispatch_queue_create("12342234", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"----1-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----2-----%@", [NSThread currentThread]);
    });
    
    // 在它前面的任务执行结束后它才执行，在它后面的任务等它执行完成后才会执行
    dispatch_barrier_async(queue, ^{
        
        for (int i = 0; i< 100; i++) {
            if (i >90) {
                NSLog(@"%d",i);
            }
            
        }
        NSLog(@"----barrier-----%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"----3-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----4-----%@", [NSThread currentThread]);
    });
    
}

- (void)test3{
    
//    //主线程死锁
//    NSLog(@"1");
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"2");
//    });
//
//    NSLog(@"3");
}

@end
