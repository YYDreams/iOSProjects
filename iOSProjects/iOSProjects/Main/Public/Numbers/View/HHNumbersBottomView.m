//
//  HHNumbersBottomView.m
//  iOSProjects
//
//  Created by funtSui on 2018/12/13.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHNumbersBottomView.h"

static CGFloat const confirmBtnWidth = 80;

static CGFloat const space = 10;

@interface HHNumbersBottomView()

@property(nonatomic,strong)UILabel *priceLabel; //单价

@property(nonatomic,strong)UILabel *totalMoenyLabel; //总价

@property(nonatomic,strong)UIButton *confirmBtn; //确定
@end

@implementation HHNumbersBottomView

#pragma mark - init Method
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupSubView];
        
    }
    return self;
    
}
- (void)setupPrice:(NSInteger)price withStakesNum:(NSInteger)stakeNum totalMoney:(NSInteger)totallMoney{
    
    self.priceLabel.text = [NSString stringWithFormat:@"单价:每口%zi日元 已选注数:%zi注",price,stakeNum];
    
    NSString *moeny = [NSString stringWithFormat:@"%zi",totallMoney];
    
    if (moeny.length > 3) {
        
        moeny = [HHNumbersBottomView countNumAndChangeformat:moeny];
    }else{
        
        moeny = [NSString stringWithFormat:@"%zi",totallMoney];
    }
    
    self.totalMoenyLabel.attributedText = [HHNumbersBottomView hh_placeholder:moeny fontSzie:13 changeColor:[UIColor blackColor] changeText:@"日元"];
    
}
#pragma mark - setupSubView
- (void)setupSubView{
    [self addSubview:self.priceLabel];
    [self addSubview:self.totalMoenyLabel];
    [self addSubview:self.confirmBtn];
    
}
#pragma mark - Custom Method
+ (NSAttributedString *)hh_placeholder:(NSString *)placeholder fontSzie:(CGFloat)fontSzie   changeColor:(UIColor *)color changeText:(NSString *)text {
    
    
    if (placeholder == nil) {
        placeholder = @"";
    }
    NSString *tip = placeholder;
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:tip];
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:fontSzie],
                                 NSForegroundColorAttributeName:color
                                 };
    
    if (text == nil) {
        text = @"";
    }
    NSAttributedString *str = [[NSAttributedString alloc]initWithString:text attributes:attributes];
    
    [attributedStr appendAttributedString:str];
    
    return  attributedStr;
}

+ (NSString *)countNumAndChangeformat:(NSString *)num{
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}

#pragma mark - SEL Method
- (void)btnOnClick:(UIButton *)sender{
    
    if (_handlerConfirmBtnCallBack) {
        _handlerConfirmBtnCallBack(sender);
    }
    
}
#pragma mark - Setter && Getter Methods
- (UILabel *)priceLabel{
    
    if (!_priceLabel) {
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(space, space, Screen_Width - confirmBtnWidth - 20, 15)];
        _priceLabel.font = [UIFont systemFontOfSize:13];
        _priceLabel.text = [NSString stringWithFormat:@"单价:每口0日元 已选注数:0注"];
    }
    return _priceLabel;
}
- (UILabel *)totalMoenyLabel{
    
    if (!_totalMoenyLabel) {
        
        _totalMoenyLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin, CGRectGetMaxY(_priceLabel.frame), Screen_Width - confirmBtnWidth - 20, 30)];
        _totalMoenyLabel.font = [UIFont boldSystemFontOfSize:20];
        _totalMoenyLabel.textColor = [UIColor redColor];
        _totalMoenyLabel.text = @"0";
    }
    return _totalMoenyLabel;
    
}
- (UIButton *)confirmBtn{
    
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(Screen_Width - 100, (self.height - 30)/2, confirmBtnWidth, 30)];
        [_confirmBtn setTitle:@"确定内容" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_confirmBtn setBackgroundImage:[UIImage imageWithColor:kThemeColor] forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_confirmBtn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
    }
    return _confirmBtn;
}
@end
