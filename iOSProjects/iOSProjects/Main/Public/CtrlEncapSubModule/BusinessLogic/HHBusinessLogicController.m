//
//  HHBusinessLogicController.m
//  iOSProjects
//
//  Created by flowerflower on 2020/8/11.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import "HHBusinessLogicController.h"
#import "HHCouponAlertView.h"
@interface HHBusinessLogicController ()

@end

@implementation HHBusinessLogicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @[@"优惠券",@"配送时间"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.titles.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
    }
    cell.textLabel.text = [self.titles safeObjectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"dsdssssssss");
    if (indexPath.row == 0) {
        
        [self addCouponView];
    }
    
}

/** 优惠券*/
- (void)addCouponView {
    HHCouponAlertView *view = [HHCouponAlertView couponPopViewWithTitle:@"优惠券" sureHandler:^(HHCouponModel * _Nonnull couponModel, HHCouponAlertView * _Nonnull view) {
      
        
    } closeHandler:^(HHCouponModel * _Nonnull couponModel, HHCouponAlertView * _Nonnull view) {
      
    }];
    
    
    

//    [self.view addSubview:view];
}


@end




