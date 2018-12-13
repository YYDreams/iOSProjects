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

@property(nonatomic,strong)UIView *topView; // (占位文字/快速选号)

@property(nonatomic,strong)UILabel *label; //占位文字 请在三个位置分别选择号码

@property(nonatomic,strong)UIButton *selectNumBtn; //快速选号

@property(nonatomic,strong)UIView *selectBgView; //快速选号遮挡View

@property(nonatomic,strong)UIPickerView *pickerView;

@property(nonatomic,strong)NSArray *dataArr;

@end
@implementation HHSelectNumbersView

#pragma mark - init Method
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
     
        [self setupSubView];
        
        [self defalutSelectedRow];
        
    }
    return self;
    
}
#pragma mark - setupSubView
- (void)setupSubView{
    
    
    [self addSubview:self.topView];

    [self.topView addSubview:self.label];
    
    [self.topView addSubview:self.selectNumBtn];
    
    [self addSubview:self.pickerView];
    
    [self addSubview:self.selectBgView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resetNotification:) name:@"kResetNotification" object:nil];
    

}
- (void)resetNotification:(NSNotification *)noti{
    
    NSLog(@"%@",noti);
    
}

#pragma mark -  Method

- (void)defalutSelectedRow{
    
    
   
   int row1 = arc4random() % 10; // [0,10)包括0，不包括10
    
    [self.pickerView selectRow:10 inComponent:0 animated:YES];
    [self.pickerView selectRow:10 inComponent:1 animated:YES];
    [self.pickerView selectRow:10 inComponent:2 animated:YES];
    
}
#pragma mark - SEL Method
- (void)btnOnClick:(UIButton *)sender{

    self.selectNumBtn.selected = !sender.selected;
    
    self.selectBgView.hidden = !self.selectNumBtn.selected;


 
    
//    if (_handlerSlectNumberBtnCallBack) {
//        _handlerSlectNumberBtnCallBack();
//    }
    
}



#pragma mark - <UIPickerViewDataSource,UIPickerViewDelegate>
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.dataArr.count ;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(8, 0, 0, kPickerViewLabelWeight)];
    label.adjustsFontSizeToFitWidth = NO;
    label.font = [UIFont boldSystemFontOfSize:25];
    label.textAlignment = NSTextAlignmentCenter;
    NSString *text = @"";
    text = [NSString stringWithFormat:@"%zd",row];
    if (text.length != 0) {
        label.text = [self.dataArr objectAtIndex:row];
    }
    if (pickerView.subviews.firstObject) { //设置默认选择的颜色
        NSArray *subViewCache = [pickerView.subviews.firstObject valueForKey:@"subviewCache"];
        
        if (subViewCache.count >0) {
            UIView *middleContainerView = [subViewCache.firstObject valueForKey:@"middleContainerView"];
            
            if (middleContainerView) {
                middleContainerView.backgroundColor = [UIColor redColor];
                
            }
        }
        
    }
    
    
    return label;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSLog(@"--------------%@",self.dataArr);
    
    
    
    NSLog(@"%@---%@--", [self.dataArr objectAtIndex:component],[self.dataArr objectAtIndex:row]);
    
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
        [_selectNumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_selectNumBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        _selectNumBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _selectNumBtn;
    
}

- (UIPickerView *)pickerView{
    
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), Screen_Width, self.height - _topView.height)];
        _pickerView.backgroundColor = [UIColor grayColor];
        _pickerView.dataSource =self;
        _pickerView.delegate = self;
    }
    return _pickerView;
    
}
- (UIView *)selectBgView{
    if (!_selectBgView) {
        _selectBgView =  [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), Screen_Width, self.height - _topView.height)];
        _selectBgView.backgroundColor = [UIColor orangeColor];
        _selectBgView.hidden = true;
        UILabel *label =  [[UILabel alloc]initWithFrame:CGRectMake(0, (self.pickerView.height - kPickerViewLabelWeight)/2, Screen_Width, kPickerViewLabelWeight)];
        label.backgroundColor = [UIColor hh_redomColor];
        label.text = @"快速选号";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:25];
        [_selectBgView addSubview:label];
    }
    return _selectBgView;
    
}
- (NSArray *)dataArr{
    
    if (!_dataArr) {
        _dataArr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"-",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    }
    return _dataArr;
}

#pragma mark - dealloc
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
