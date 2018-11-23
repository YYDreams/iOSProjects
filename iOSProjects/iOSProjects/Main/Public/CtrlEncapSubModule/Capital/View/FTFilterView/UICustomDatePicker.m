//
//  UICustomDatePicker.m
//  LengBaoBao
//
//  Created by mac on 2017/6/25.
//  Copyright © 2017年 leng360. All rights reserved.
//

#import "UICustomDatePicker.h"
//#import "UIView+CustomFrame.h"

@interface UICustomDatePicker()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayout;
@property (weak, nonatomic) IBOutlet UIButton *bgButton;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView        *bottomView;
@property (nonatomic, copy  ) void(^dateBlock)(NSDate *date);
@property (nonatomic, copy  ) void(^cancelBlock)(void);
@end

@implementation UICustomDatePicker

+ (void) showCustomDatePickerAtView:(UIView *)superView choosedDateBlock:(void (^)(NSDate *date))date cancelBlock:(void(^)())cancel
{
    if ([superView viewWithTag:1887]) {
        [[superView viewWithTag:1887] removeFromSuperview];
    }
    UICustomDatePicker *picker = [[UINib nibWithNibName:@"UICustomDatePicker" bundle:nil] instantiateWithOwner:nil options:nil].firstObject;
    picker.tag = 1887;
    [superView addSubview:picker];
    
    
    
    picker.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:picker
                                                       attribute:NSLayoutAttributeTop
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:superView
                                                       attribute:NSLayoutAttributeTop
                                                      multiplier:1.0
                                                        constant:0.0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:picker
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0.0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:picker
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    [superView addConstraint:[NSLayoutConstraint constraintWithItem:picker
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:superView
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0.0]];
    [picker layoutIfNeeded];
    
    picker.bottomLayout.constant = 0;
    picker.bgButton.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        [picker layoutIfNeeded];
        picker.bgButton.alpha = 1;
    }];
    if (date) {
        picker.dateBlock = date;
    }
    if (cancel) {
        picker.cancelBlock = cancel;
    }
    
}


- (IBAction)dismissBtnAction:(id)sender {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self hideAnimation];
}
- (IBAction)confirmBtnAction:(id)sender {
    if (self.dateBlock) {
        self.dateBlock(self.datePicker.date);
    }
    [self hideAnimation];
}

- (void)hideAnimation
{
    self.bottomLayout.constant = -260;
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
        self.bgButton.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
