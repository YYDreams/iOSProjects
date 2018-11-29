//
//  HHNavTitleView.m
//  iOSProjects
//
//  Created by funtSui on 2018/11/27.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHNavTitleView.h"
@interface HHNavTitleView()

@property(nonatomic, strong)UILabel *typeLabel; // 标准 or 快捷

@property(nonatomic, strong)UILabel *titleLabel; //

@property(nonatomic, strong)UIImageView *imageView; //

@property(nonatomic, strong)UIButton  *selectBtn; //

@end
@implementation HHNavTitleView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self commonInit];
    }
    
    return self;
}
- (void)setupSubView{
    
    [self addSubview:self.typeLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.imageView];
    [self addSubview:self.selectBtn];
    
}
- (void)commonInit{
    
    [self setupSubView];
    
    self.textColor = [UIColor whiteColor];
    
    self.imageView.image = [UIImage imageNamed:@"ssc_arrow_up_white"];
    
    _font = [UIFont systemFontOfSize:17];
    
}
- (void)defalutTitleModel:(SSCStructModel *)titModel{
    
    if (titModel.standard.count >0) {
        
        [self setType:HHNavTitleViewTypePlayStandard title:titModel.standard.firstObject.nm];
        
    }else{
        [self setType:HHNavTitleViewTypePlayFast title:titModel.fast.firstObject.nm];
    }
    
    
}
- (void)setType:(HHNavTitleViewType)type title:(NSString *)title{
    
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
    
    CGFloat typeWidth = 0;
    switch (type) {
        case HHNavTitleViewTypeNormal:{
            self.typeLabel.hidden = true;
            typeWidth = 0;
        }
            break;
        case HHNavTitleViewTypePlayFast:
        case HHNavTitleViewTypePlayStandard:{
            self.typeLabel.hidden = false;
            self.typeLabel.text = (type == HHNavTitleViewTypePlayFast) ? @"快捷": @"标准";
            typeWidth = self.typeLabel.width;
        }
            break;
        default:
            break;
            
    }
    self.titleLabel.centerY = self.height / 2;
    self.titleLabel.centerX = self.width/2 - (self.imageView.width + 5 - typeWidth -2)/2;
    
    self.typeLabel.right = self.titleLabel.left - 2;
    self.typeLabel.centerY = self.titleLabel.centerY;
    
    self.imageView.centerY = self.titleLabel.centerY;
    self.imageView.left = self.titleLabel.right + 5;
    
}

- (void)btnOnClick:(UIButton *)sender{
    _selectBtn.selected = !sender.selected;
    if (self.handlerTitleOnClick != nil) {
        self.handlerTitleOnClick(sender.selected);
    }
    
}
- (void)setIsSelected:(BOOL)isSelected{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.imageView.transform =  CGAffineTransformMakeRotation(isSelected ? M_PI: 0);
        
    }];
}
#pragma mark - Setter && Getter Methods
- (void)setFont:(UIFont *)font{
    
    _font = font;
    self.titleLabel.font = font;
}
- (void)setTextColor:(UIColor *)textColor{
    
    _textColor = textColor;
    self.titleLabel.textColor = textColor;
}
- (void)setArrowImage:(NSString *)arrowImage{
    
    _arrowImage = arrowImage;
    self.imageView.image = [UIImage imageNamed:arrowImage];
}
- (UIImageView *)imageView {
    
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeCenter;
        _imageView.size = CGSizeMake(10, 10);
        _imageView.left = 0;
        _imageView.top = 0;
    }
    return _imageView;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 28, 17)];
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        _typeLabel.textColor = kThemeColor;
        _typeLabel.hidden = true;
        _typeLabel.font = [UIFont systemFontOfSize:10];
        _typeLabel.backgroundColor = [UIColor whiteColor];
        _typeLabel.layer.cornerRadius = 4;
        _typeLabel.layer.masksToBounds = true;
    }
    return _typeLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UIButton *)selectBtn{
    
    if (!_selectBtn) {
        _selectBtn = [[UIButton alloc]initWithFrame:self.bounds];
        _selectBtn.selected = YES;
        [_selectBtn addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}
@end
