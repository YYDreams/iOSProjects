//
//  HHPickerComponent.m
//  iOSProjects
//
//  Created by funtSui on 2019/1/24.
//  Copyright © 2019年 flowerflower. All rights reserved.
//

#import "HHPickerComponent.h"
@interface HHPickerComponent()

@property(nonatomic,strong)UIView *pickerView;

@end
static const CGFloat kPickerViewHeight = 260.0f;

@implementation HHPickerComponent

- (instancetype)init {
    if (self = [super init]) {
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapedSelf:)];
        tapGes.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapGes];
        self.backgroundColor =  [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:102.0/255];
        
    }
    return self;
}

- (void)tapedSelf:(UITapGestureRecognizer *)tap {
    CGPoint location = [tap locationInView:self];
    
    // 点击空白背景移除self
    if (location.y <= [UIScreen mainScreen].bounds.size.height - kPickerViewHeight) {
        
        [self hide];
    }
}


+ (HHPickerComponent *)showSinglePickerWithToolBarTitle:(NSString *)toolBarTitle withData:(NSArray<NSString *> *)data withDefaultIndex:(NSInteger)defaultIndex cancelHandler:(HHPickerComponentCancelBlock)cancelHandler withDoneHandler:(HHPickerComponentDoneBlock)doneHandler{
    
    
    HHPickerComponent *pickerViewComponent = [[HHPickerComponent alloc]init];
    
    HHSinglePickerView *singlePickerView = [[HHSinglePickerView alloc]initWithToolBarTitle:toolBarTitle withData:data withDefaultIndex:defaultIndex cancelAction:^{
       
        
    } doneAction:^(NSInteger selectedIndex, NSString *selectedValue) {
       
    }];
    
    [pickerViewComponent show];
    
    pickerViewComponent.pickerView = singlePickerView;
    
    return pickerViewComponent;
    
}

- (void)show{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.pickerView.frame = CGRectMake(0,  [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, kPickerViewHeight);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1];
        self.pickerView.frame = CGRectMake(0,  [UIScreen mainScreen].bounds.size.height - kPickerViewHeight, [UIScreen mainScreen].bounds.size.width, kPickerViewHeight);

    }];
    
}
- (void)hide{
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.pickerView.frame = CGRectMake(0,  [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, kPickerViewHeight);

        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.superview) {
        self.frame = self.superview.bounds;
        self.pickerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - kPickerViewHeight, [UIScreen mainScreen].bounds.size.width, kPickerViewHeight);
        
    }
}
- (void)setPickerView:(UIView *)pickerView{
    
    _pickerView = pickerView;
    [self addSubview:_pickerView];
    
}


- (HHPickerToolBar *)toolBar{
    
    if ([self.pickerView isKindOfClass:[HHSinglePickerView class]]) {
        return ((HHSinglePickerView *)self.pickerView).toolBar;
    }else {
        return [HHPickerToolBar new];
    }

}



@end
