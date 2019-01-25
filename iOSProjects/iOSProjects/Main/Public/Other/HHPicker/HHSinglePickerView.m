//
//  HHSinglePickerView.m
//  iOSProjects
//
//  Created by funtSui on 2019/1/24.
//  Copyright © 2019年 flowerflower. All rights reserved.
//

#import "HHSinglePickerView.h"
#import "HHPickerToolBar.h"
@interface HHSinglePickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)UIPickerView *pickerView;

@property(nonatomic,strong)NSArray *dataArr;

@property(nonatomic,assign)NSInteger selectedIndex;

@property (assign, nonatomic)NSString *selectedValue;

@end

@implementation HHSinglePickerView
- (instancetype)initWithToolBarTitle:(NSString *)toolBarTitle withData:(NSArray<NSString *> *)data withDefaultIndex:(NSInteger)defaultIndex  cancelAction:(HHPickerComponentCancelBlock)cancelAction doneAction: (HHPickerComponentDoneBlock)doneAction{
    
    if (self = [super init]) {
        _dataArr = data;
        
        
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.toolBar.frame = CGRectMake(0, 0,Screen_Width, 44);
//    self.pickerView.frame = CGRectMake(0, CGRectGetMaxY(<#CGRect rect#>), <#CGFloat width#>, <#CGFloat height#>)
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.dataArr.count;
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
    
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:18.0f];
    label.adjustsFontSizeToFitWidth = YES;
    label.text = self.dataArr[row];
    return label;
}
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        
    }
    
    return _pickerView;
}



@end
