//
//  HHLotteryListCell.h
//  iOSProjects
//
//  Created by flowerflower on 2018/11/9.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHResultView.h"
#import "HHLotteryListModel.h"
@interface HHLotteryListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lottery_numberLabel;
@property (weak, nonatomic) IBOutlet HHResultView *resultView;

@property (weak, nonatomic) IBOutlet UIButton *trendBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resultWidthConst;

/** <#注释#> */
@property (nonatomic, strong) HHLotteryListModel *model;
@end
