//
//  RMStrikethroughLabel.m
//  RMDart
//
//  Created by flowerflower on 2018/5/24.
//  Copyright © 2018年 花花. All rights reserved.
//

#import "RMStrikethroughLabel.h"

@implementation RMStrikethroughLabel{
    UIView *_lineView;
}

- (instancetype) initWithFrame:(CGRect)frame{

    
    if (self = [super initWithFrame:frame]) {
        _lineView = [[UIView alloc]init];
        [self addSubview:_lineView];
        _lineView.backgroundColor = self.textColor;
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.left.right.mas_equalTo(self);
            make.height.mas_equalTo(1);
        }];
        
    }
    
    return self;
}
- (void)setTextColor:(UIColor *)textColor{
    super.textColor = textColor;
    _lineView.backgroundColor = textColor;
}

@end
