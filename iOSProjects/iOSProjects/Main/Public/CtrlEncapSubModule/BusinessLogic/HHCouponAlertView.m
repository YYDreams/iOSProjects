//
//  HHCouponAlertView.m
//  iOSProjects
//
//  Created by flowerflower on 2020/8/11.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "HHCouponAlertView.h"
#import <MJRefresh/MJRefresh.h>
#define UIColorMake(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]


@implementation HHCouponModel

@end

@interface HHCouponAlertView()


@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *backButton;
@property (nonatomic, weak) UIButton *closeButton;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) NSArray *couponsArray;

@property (nonatomic, weak) UITableView *tableView;


@property (nonatomic, copy) void (^sureHandler)(HHCouponModel *model,HHCouponAlertView *view);
@property (nonatomic, copy) void (^closeHandler)(HHCouponModel *model,HHCouponAlertView *view);


@end

@implementation HHCouponAlertView


+ (instancetype)couponPopViewWithTitle:(NSString *)title
                           sureHandler:(void(^)(HHCouponModel *couponModel,HHCouponAlertView *view))sureHandler
                          closeHandler:(void(^)(HHCouponModel *couponModel,HHCouponAlertView *view))closeHandler{
    
    HHCouponAlertView *view = [[ HHCouponAlertView alloc]initWithTitle:title];
      view.sureHandler = sureHandler;
      view.closeHandler = closeHandler;
      return view;

}

- (instancetype)initWithTitle:(NSString *)title{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)updateData:(NSArray *)coupons noMore:(BOOL)noMore errorMsg:(NSString *)errorMsg{
    
    self.couponsArray = coupons;
    [self.tableView.mj_header endRefreshing];
    if (noMore) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }else {
        [self.tableView.mj_footer endRefreshing];
    }
    
//    if (self.pageType == QSLiveRoomCouponContentViewCouponPage) {
//        if (self.couponsArray.count) {
//            [self.tableViewBaseView hideNoDataErrorView];
//        }else {
//            [self.tableViewBaseView showNoDataErrorView];
//
//        }
//    }
    
    
    
}

#pragma mark - tableViewDelegate tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.couponsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
 
}

#pragma mark - setter
- (void)setCouponsArray:(NSArray *)couponsArray {
    
    _couponsArray = couponsArray;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    [self.tableView reloadData];
}

@end
