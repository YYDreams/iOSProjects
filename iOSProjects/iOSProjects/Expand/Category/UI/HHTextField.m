//
//  JYTextField.m
//  JYFarm
//
//  Created by LOVE on 2017/12/7.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "HHTextField.h"


@interface HHTextField ()

@property (nonatomic, strong)UIView *bar;

@end

@implementation HHTextField

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    if (!_bar) {
        _bar = [[UIView alloc] initWithFrame:CGRectMake(0,0, Screen_Width,44)];

    }
    _bar.backgroundColor = kBgColor;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width - 70, 7,60, 30)];
    
    [button setTitle:@"完成"forState:UIControlStateNormal];
    
    [button setTitleColor:kThemeColor forState:UIControlStateNormal];
    
    button.layer.borderColor = [UIColor colorWithHexString:@"62C6B2"].CGColor;
    
    button.layer.borderWidth =1;
    
    button.layer.cornerRadius =3;
    
    [_bar addSubview:button];
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        
    }];
    
    [button addTarget:self action:@selector(print) forControlEvents:UIControlEventTouchUpInside];
    self.inputAccessoryView.userInteractionEnabled = YES;
    self.inputAccessoryView = _bar;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    __block  UIView * view = [super hitTest:point withEvent:event];
    if (view == nil) {
        // 转换坐标系
        
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[UIButton class]]) {
                view = obj;
                *stop = YES;
            }
        }];
        CGPoint newPoint = [view convertPoint:point fromView:self];
        // 判断触摸点是否在button上
        if (CGRectContainsPoint(view.bounds, newPoint)) {
            view = view;
        }else{
            return nil;
        }
    }
    return view;
}

- (void) print {
    
    if (self.finishCallBack) {
        self.finishCallBack();
    }
    
    
}
@end
