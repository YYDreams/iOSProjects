//
//  HHPickerToolBar.m
//  iOSProjects
//
//  Created by funtSui on 2019/1/24.
//  Copyright © 2019年 flowerflower. All rights reserved.
//

#import "HHPickerToolBar.h"

@interface HHPickerToolBar()

@property(nonatomic,strong)UIButton *cancelBtn;

@property(nonatomic,strong)UIButton *doneBtn;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,copy)BtnAction  cancelBlock;

@property(nonatomic,copy)BtnAction  doneBlock;

@end
@implementation HHPickerToolBar

- (instancetype)initWithToolbarTitle:(nullable NSString *)toolBarTitle cancelAction:(BtnAction)cancelAction doneAction:(BtnAction)doneAction{
    
    if (self = [super init]) {
     
        self.titleLabel.text = toolBarTitle;
        _cancelBlock = [cancelAction copy];
        _doneBlock = [doneAction copy];
        
        [self commonInit];
    }
    return self;
}
- (void)commonInit{
    
    _title = @"";
    _font = [UIFont systemFontOfSize:15];
    _titleColor = [UIColor blackColor];
    self.bounds = CGRectMake(0, 0, self.frame.size.width, 44);
    
    [self addSubview:self.cancelBtn];
    [self addSubview:self.doneBtn];
    [self addSubview:self.titleLabel];
}
- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
       _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 2, 44, 40)];
        [_cancelBtn setTitleColor:self.titleColor forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn.titleLabel setFont:self.font];

        
    }
    return _cancelBtn;
    
}
- (UIButton *)doneBtn{
    if (!_doneBtn) {
        _doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 44 - 15, 2, 44, 40)];
        [_doneBtn setTitleColor:self.titleColor forState:UIControlStateNormal];
        [_doneBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_doneBtn.titleLabel setFont:self.font];
  
    }
    return _doneBtn;
}
- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.cancelBtn.frame)+ 5, 0,self.frame.size.width - 2 *44-15, 44)];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        _titleLabel.textColor = self.titleColor;
        _titleLabel.font  = self.font;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        
    }
    return _titleLabel;
    
}
- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    [self.cancelBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [self.doneBtn setTitleColor:titleColor forState:UIControlStateNormal];
}
- (void)setFont:(UIFont *)font{
    _font = font;
    self.cancelBtn.titleLabel.font = font;
    self.doneBtn.titleLabel.font = font;
    self.titleLabel.font = font;
  
}
@end
