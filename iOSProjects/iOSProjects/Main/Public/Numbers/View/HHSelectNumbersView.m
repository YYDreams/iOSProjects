//
//  HHSelectNumbersView.m
//  iOSProjects
//
//  Created by funtSui on 2018/12/12.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHSelectNumbersView.h"

static CGFloat const kPickerViewLabelWeight = 50;

@interface HHSelectNumbersView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong)UIView *topView;

@property(nonatomic,strong)UILabel *label;

@property(nonatomic,strong)UIButton *selectNumBtn;


@property(nonatomic,strong)UIPickerView *pickerView;


@property(nonatomic,strong)NSArray *dataArr;

@end
@implementation HHSelectNumbersView

#pragma mark - init Method
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
     
        [self setupSubView];
        
    }
    return self;
    
}


#pragma mark - setupSubView
- (void)setupSubView{
    
    
    _dataArr = @[@"0",@"1",@"2",@"3",@"4",@"5"];
    [self addSubview:self.topView];

    [self.topView addSubview:self.label];
    
    [self.topView addSubview:self.selectNumBtn];
    
    [self addSubview:self.pickerView];
    

    [self.pickerView reloadAllComponents];
}


#pragma mark - SEL Method
- (void)btnOnClick{
    
    
  
    if (_handlerSlectNumberBtnCallBack) {
        _handlerSlectNumberBtnCallBack();
    }
    
}



#pragma mark - <UIPickerViewDataSource,UIPickerViewDelegate>
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    
    return 3;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return 10;
    
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(8, 0, 0, kPickerViewLabelWeight)];
    label.adjustsFontSizeToFitWidth = NO;
    label.backgroundColor = [UIColor redColor];
    label.font = [UIFont boldSystemFontOfSize:25];
    label.textAlignment = NSTextAlignmentCenter;
    NSString *text = @"";
    text = [NSString stringWithFormat:@"%zd",row];
    if (text.length != 0) {
        label.text = text;
        
    }
    return label;
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return kPickerViewLabelWeight;
}
#pragma mark - Setter && Getter Methods
- (UIView *)topView{
    
    
    if (!_topView) {
    
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
        
    }
    return _topView;
    
}

- (UILabel *)label{
    
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, (_topView.height -15) / 2, Screen_Width - 10 - 80 , 15)];
        _label.text = @" 请在三个位置分别选择号码";
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont systemFontOfSize:15];
 
    }
    return _label;
    
    
}
- (UIButton *)selectNumBtn{
    
    if (!_selectNumBtn) {
        _selectNumBtn = [[UIButton alloc]initWithFrame:CGRectMake(Screen_Width - 80 ,(_topView.height - 30)/2, 80, 30)];
        [_selectNumBtn setTitle:@"快速选号" forState:UIControlStateNormal];
        [_selectNumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_selectNumBtn addTarget:self action:@selector(btnOnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _selectNumBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _selectNumBtn;
    
}

- (UIPickerView *)pickerView{
    
    if (!_pickerView) {
        
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), Screen_Width, self.height - _topView.height)];
        _pickerView.backgroundColor = kBgColor;
        _pickerView.dataSource =self;
        _pickerView.delegate = self;
        
    }
    return _pickerView;
    
}

@end
