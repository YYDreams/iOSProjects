//
//  FTBuyLotteryLobbyViewController.m
//  iOSProjects
//
//  Created by funtSui on 2018/11/28.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "FTBuyLotteryLobbyViewController.h"
#import "FTLottertCategory.h"
#import <YYModel/YYModel.h>
#import "SSCViewController.h"
@interface FTBuyLotteryLobbyViewController ()

// 房间模式
@property(nonatomic,strong)NSArray *roomArray;
//传统模式
@property(nonatomic,strong)NSArray *patternArray;




@end

@implementation FTBuyLotteryLobbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"BuyLotteryCellID"];
    [self loadDataFromNetwork];
}


- (void)loadDataFromNetwork{
    
    [HTTPRequest GET:kGameLotteryUrl parameter:nil success:^(id resposeObject) {
        if (resposeObject != nil) {
            
            self.roomArray  = [NSArray yy_modelArrayWithClass:[FTLottertCategory class] json:resposeObject[@"data"][@"chat"]];
            self.patternArray = [NSArray yy_modelArrayWithClass:[FTLottertCategory class] json:resposeObject[@"data"][@"standard"]];
            
            
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
       
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.patternArray.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BuyLotteryCellID"];
    cell.textLabel.text = [self.patternArray[indexPath.row] name];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FTLottertCategory *model = self.patternArray[indexPath.row];
    SSCViewController *sscVC = [[SSCViewController alloc]init];
    sscVC.model = model;
    
    [self.navigationController pushViewController:sscVC animated:true];
    
}


@end
