//
//  HHCouponAlertView.h
//  iOSProjects
//
//  Created by flowerflower on 2020/8/11.
//  Copyright © 2020 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"
@interface HHCouponModel : BaseModel

@end
NS_ASSUME_NONNULL_BEGIN

@interface HHCouponAlertView : UIView

@property(nonatomic ,strong)NSArray *dataArr;


+ (instancetype)couponPopViewWithTitle:(NSString *)title
                           sureHandler:(void(^)(HHCouponModel *couponModel,HHCouponAlertView *view))sureHandler
                           closeHandler:(void(^)(HHCouponModel *couponModel,HHCouponAlertView *view))closeHandler;


- (void)updateData:(NSArray *)coupons noMore:(BOOL)noMore errorMsg:(NSString *)errorMsg;
@end

NS_ASSUME_NONNULL_END
