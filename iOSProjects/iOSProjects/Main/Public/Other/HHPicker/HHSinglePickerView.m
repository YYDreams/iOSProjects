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

@property(nonatomic,copy)HHPickerComponentSelectedBlock  selectedBolck; 

@end

@implementation HHSinglePickerView
- (instancetype)initWithToolBarTitle:(NSString *)toolBarTitle withData:(NSArray<NSString *> *)data withDefaultIndex:(NSInteger)defaultIndex  cancelAction:(HHPickerComponentCancelBlock)cancelAction doneAction: (HHPickerComponentDoneBlock)doneAction{
    
    if (self = [super init]) {
        _dataArr = data;
        
        if (defaultIndex < 0 || defaultIndex >= data.count) {
            
            NSLog(@"设置的默认下标有问题, 将被设置为0");
            defaultIndex = 0;
        }
        _selectedIndex = defaultIndex;
        
        [self selectedValueDidChanged];
        __weak typeof(self) weakSelf = self;
        _toolBar = [[HHPickerToolBar alloc]initWithToolbarTitle:toolBarTitle cancelAction:cancelAction doneAction:^{
           
            if (doneAction) {
               
                doneAction(weakSelf.selectedIndex,weakSelf.selectedValue);
                
            }
            
            
        }];
        
        [self.pickerView selectRow:_selectedIndex inComponent:0 animated:NO];
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.pickerView];
        [self addSubview:_toolBar];
        
    }
    return self;
}
- (void)dealloc{
    
  NSLog(@"HHSinglePickerView=======dealloc");
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.toolBar.frame = CGRectMake(0, 0,Screen_Width, 44);
    self.pickerView.frame = CGRectMake(0, CGRectGetMaxY(self.toolBar.frame),Screen_Width, self.height - self.toolBar.height);
    
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
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _selectedIndex = row;
    [self selectedValueDidChanged];
    
}

- (void)selectedValueDidChanged{
    
    if (_selectedBolck) {
        _selectedBolck(self.selectedValue);
    }
    
}
- (NSString *)selectedValue{
    
    if (_selectedIndex >= 0 && _selectedIndex < self.dataArr.count) {
        _selectedValue = self.dataArr[_selectedIndex];
    }
    
    return _selectedValue;
    
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
