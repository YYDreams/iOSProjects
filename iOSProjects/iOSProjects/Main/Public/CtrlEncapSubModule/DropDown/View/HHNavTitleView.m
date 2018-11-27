//
//  HHNavTitleView.m
//  iOSProjects
//
//  Created by funtSui on 2018/11/27.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHNavTitleView.h"
@interface HHNavTitleView()

@property (strong, nonatomic) UIView *contentView;


@property(nonatomic, strong)UILabel *typeLabel; // 标准 or 快捷

@property(nonatomic, strong)UILabel *titleLabel; //


@property(nonatomic, strong)UIButton  *titleBtn; //


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
//    [self addSubview:self.titleBtn];
}
- (void)commonInit{
    
    [self setupSubView];
    
    _arrowType = HHNavTitleViewArrowTypeDown;

    _showImage = NO;
    
    self.textColor = [UIColor whiteColor];

    self.imageView.image = [UIImage imageNamed:@"ssc_arrow_up_white"];
    
    _font = [UIFont systemFontOfSize:17];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
    
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
    self.arrowType = HHNavTitleViewArrowTypeDown;
 
}


- (void)tapAction{
    
    _arrowType  = HHNavTitleViewArrowTypeUp;
    
    
    
    if (self.handlerTitleOnClick != nil) {
        self.handlerTitleOnClick(self);
    }
    
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

- (void)setArrowType:(HHNavTitleViewArrowType)arrowType{
    
    _arrowType = arrowType;
    
    if (arrowType == HHNavTitleViewArrowTypeUp) {
        [UIView animateWithDuration:0.25 animations:^{
           
            self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }else{
        
        [UIView animateWithDuration:0.25 animations:^{
           
            self.imageView.transform = CGAffineTransformMakeRotation(0);
        }];
    }
    
    
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
//- (UIButton *)titleBtn{
//
//    if (!_titleBtn) {
//        _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//
//        [_titleBtn setImage:[UIImage imageNamed:@""] forState:<#(UIControlState)#>]
//        [_titleBtn.titleLabel sizeToFit];
//
//
//    }
//
//    return _titleBtn;
//}
//



- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
    }
    return _contentView;
}

@end
