//
//  SSCStructSuperView.m
//  iOSProjects
//
//  Created by funtSui on 2018/11/28.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "SSCStructSuperView.h"
@interface SSCStructSuperView()
@property (nonatomic,strong)UIView *rootView;

@property (nonatomic,strong)UIButton *backGroundView;

@property (nonatomic,strong)UIView *whiteView;//白色页面

@property (nonatomic,strong)NSArray *standardArray;//标准
@property (nonatomic,strong)NSArray *fastArray;//快捷

@property(nonatomic,strong)UIView *bgView;

@end
@implementation SSCStructSuperView
- (instancetype)initWithFrame:(CGRect)frame rootView:(UIView *)rootView {
    
    if (self = [super initWithFrame:frame]) {
        
        self.rootView = rootView;

        [self setupSubView];
    }
    return self;
}
- (UIButton *)backGroundView{
    
    if (!_backGroundView) {
        _backGroundView = [[UIButton alloc]initWithFrame:_rootView.bounds];
        [_backGroundView addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        _backGroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        _backGroundView.alpha = 0;
    }
    return _backGroundView;
}

- (void)setupSubView{
    
    UIView *whiteView = [[UIView alloc]initWithFrame:self.bounds];
    whiteView.backgroundColor = [UIColor whiteColor];
    self.whiteView = whiteView;
    [self addSubview:whiteView];

}
#pragma mark - Actions

- (void)show{
    [self.rootView addSubview:self.backGroundView];
    [self.rootView addSubview:self];
    self.backGroundView.alpha = 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.backGroundView.alpha = 1;
    }];
    
}

- (void)close{
    [UIView animateWithDuration:0.25 animations:^{
        self.backGroundView.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.backGroundView removeFromSuperview];
    }];
}

//设置数据源
- (void)setStandardMehtods:(NSArray <SSCSuperModel*>*)standardArray fastMethods:(NSArray <SSCSuperModel*>*)fastArray{
    
    _standardArray = standardArray;
    _fastArray = fastArray;
    
    NSArray *subViews = self.whiteView.subviews;
    
    for (UIView *view in subViews) {
        [view removeFromSuperview];
    }
    

    
    
    
}



@end
