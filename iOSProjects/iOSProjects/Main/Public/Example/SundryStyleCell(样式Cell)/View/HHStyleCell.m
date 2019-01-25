//
//  HHStyleCell.m
//  HHTableViewCellStyleDemo
//
//  Created by flowerflower on 2018/7/19.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "HHStyleCell.h"


@interface HHStyleCell()
/******************* 左边部分 ********************/
@property(nonatomic,strong) UILabel *leftTitleLabel;  //左侧的Label

@property(nonatomic,strong) UIImageView *leftImageView;  // 左侧的imgView

/******************* 右边部分 ********************/

@property (nonatomic, strong) UIImageView *indicatorArrow;              //右侧的箭头
//@property (nonatomic, strong) UIImageView *indicatorLeftImageView;      //右侧的箭头的左边的imageview
@property (nonatomic, strong) UILabel *rightLabel;              //右侧的箭头的左边的Label
@property (nonatomic, strong) UISwitch *indicatorSwitch;                //右侧的箭头的左边的开关

@property (nonatomic, strong) UILabel *logoutLabel;                     //退出登录的label

@end

@implementation HHStyleCell

- (void)setModel:(HHStyleViewModel *)model{
    
    _model = model;
    
    [self setupSubView];
    
    
}
- (void)setupSubView{
    
    
    //如果有左边的图片
    if (self.model.leftImg) {
        
        [self setupImgView];
        
    }
    
    //如果有左边的文字
    if (self.model.leftTitle) {
        [self setupTitle];
    }
    
    //accessoryType
    
    if (self.model.accessoryType) {
        
        [self setupAccessoryType];
    }
    
    //subTitle
    if (self.model.rightSubtitle) {
        
        [self setupSubTitle];
        
        
    }
    
    if (self.model.logoutTitle) {
        
        [self setupLogout];
    }
    
    //arrow
    if (self.model.indicatorArrow) {
        
        [self setupIndicatorArrow];

    }
    

    
    
}
- (void)setupIndicatorArrow{
    
    
    self.indicatorArrow = [[UIImageView alloc]initWithImage:self.model.indicatorArrow];
    
    self.indicatorArrow.centerY = self.contentView.centerY;
    switch (self.model.accessoryType) {
        case HHCellAccessoryTypeNone:
            self.indicatorArrow.x = Screen_Width - self.indicatorArrow.width - kIndicatorToRightMargin - 2;
            break;
        case HHCellAccessoryTypeDisclosureIndicator:
            self.indicatorArrow.x = self.indicatorArrow.x - self.indicatorArrow.width - kIndicatorToRightMargin;
            break;
        case HHCellAccessoryTypeSwitch:
            self.indicatorArrow.x = self.indicatorSwitch.x - self.indicatorArrow.width - kIndicatorToRightMargin;
            break;
        default:
            break;
    }
    [self.contentView addSubview:self.indicatorArrow];
    
    
    
}
- (void)setupLogout{
    

    [self.contentView addSubview:self.logoutLabel];
    
    self.logoutLabel.font = self.model.leftTextFont;
    self.logoutLabel.textColor = self.model.leftTextColor;
    self.logoutLabel.text = self.model.logoutTitle;
    
    self.logoutLabel.size = [self.model.logoutTitle sizeForTitle:self.model.logoutTitle font:self.model.leftTextFont];
    
    self.logoutLabel.centerY = self.contentView.centerY;
    
    self.logoutLabel.x = (Screen_Width - self.logoutLabel.size.width)/2;
}
- (void)setupSubTitle{
    
    
    self.rightLabel.text = self.model.rightSubtitle;
    self.rightLabel.font = self.model.leftTextFont;
    self.rightLabel.textColor = self.model.leftTextColor;
    self.rightLabel.size = [self.model.rightSubtitle sizeForTitle:self.model.rightSubtitle font:self.rightLabel.font];
    self.rightLabel.centerY = self.contentView.centerY;

    switch (self.model.accessoryType) {
        case HHCellAccessoryTypeNone:
            self.rightLabel.x =  Screen_Width - self.rightLabel.width - kIndicatorToRightMargin;
            break;
        case HHCellAccessoryTypeDisclosureIndicator:
            self.rightLabel.x = self.indicatorArrow.x - self.rightLabel.width;
//            - kIndicatorToRightMargin;
            
            break;
        case HHCellAccessoryTypeSwitch:
            
            self.rightLabel.x = self.indicatorSwitch.x  - self.rightLabel.width - kIndicatorToRightMargin;
            break;

        case HHCellAccessoryTypeOther:
            
            
            break;
        default:
            break;
    }
    
    
    
    [self.contentView addSubview:self.rightLabel];
    
}

- (void)setupAccessoryType{
    
    
    switch (self.model.accessoryType) {
        case HHCellAccessoryTypeNone:
            
            break;
        case HHCellAccessoryTypeDisclosureIndicator:
            
            [self.contentView addSubview:self.indicatorArrow];
            
            break;
        case HHCellAccessoryTypeSwitch:
            
            [self.contentView addSubview:self.indicatorSwitch];
            
            break;
        case HHCellAccessoryTypeLogout:
            [self.contentView addSubview:self.logoutLabel];
            
            
            break;
        case HHCellAccessoryTypeOther:
            
            break;
        default:
            break;
    }


}
- (void)setupImgView{
    self.leftImageView = [[UIImageView alloc]initWithImage:self.model.leftImg];
    
    self.leftImageView.x = margin;
    self.leftImageView.centerY = self.contentView.centerY;
    
    [self.contentView addSubview:self.leftImageView];

    
}
- (void)setupTitle{
    

    [self.contentView addSubview:self.leftTitleLabel];
    
    self.leftTitleLabel.font = self.model.leftTextFont;
    self.leftTitleLabel.textColor = self.model.leftTextColor;
    self.leftTitleLabel.text = self.model.leftTitle;

    self.leftTitleLabel.size = [self.model.leftTitle sizeForTitle:self.model.leftTitle font:self.model.leftTextFont];
    
    self.leftTitleLabel.centerY = self.contentView.centerY;
    
    self.leftTitleLabel.x = CGRectGetMaxX(self.leftImageView.frame) +  margin;
    
}
- (void)switchOnClick:(UISwitch *)sender{

    if (_handlerSwitchCallBack) {
        _handlerSwitchCallBack(sender.isOn);
        
    }
}
#pragma mark - Setter && Getter Methods

- (UIImageView *)indicatorArrow{

    if (!_indicatorArrow) {
        _indicatorArrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
        _indicatorArrow.centerY = self.contentView.centerY;
        _indicatorArrow.x = Screen_Width - _indicatorArrow.width - kIndicatorToRightMargin;
        
    }
    return _indicatorArrow;

}
- (UISwitch *)indicatorSwitch{
    
    
    if (!_indicatorSwitch) {
        _indicatorSwitch = [[UISwitch alloc]init];
        _indicatorSwitch.centerY = self.contentView.centerY;
        _indicatorSwitch.x = Screen_Width - _indicatorSwitch.width  - kIndicatorToRightMargin;
       [_indicatorSwitch addTarget:self action:@selector(switchOnClick:) forControlEvents:UIControlEventValueChanged];
    }
    return _indicatorSwitch;
    
}

- (UILabel *)logoutLabel{
    
    if (!_logoutLabel) {
        _logoutLabel = [[UILabel alloc]init];
        _logoutLabel.textAlignment = NSTextAlignmentCenter;

    }
    return _logoutLabel;
    
}
- (UILabel *)rightLabel{
    
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];

    }
    return _rightLabel;
    
}
- (UILabel *)leftTitleLabel{
    
    if (!_leftTitleLabel) {
        _leftTitleLabel = [[UILabel alloc]init];
    }
    return _leftTitleLabel;
}
@end
