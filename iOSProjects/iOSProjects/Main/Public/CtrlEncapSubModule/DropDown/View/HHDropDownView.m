//
//  HHDropDownView.m
//  iOSProjects
//
//  Created by funtSui on 2018/11/27.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHDropDownView.h"

@interface HHDropDownView()
@property(nonatomic,strong)UIView *rootView;

@property(nonatomic,assign)BOOL *isCategory;

@property(nonatomic,strong)UIButton *backGroundView;

@end
@implementation HHDropDownView

- (instancetype)initWithFrame:(CGRect)frame rootView:(UIView *)rootView showCategory:(BOOL)showCategory{
    
    if (self = [super initWithFrame:frame]) {

        self.rootView = rootView;

        UIButton *view = [[UIButton alloc]initWithFrame:_rootView.bounds];
        self.backGroundView = view;
        [view addTarget:self action:@selector(backGroundViewDidClick) forControlEvents:UIControlEventTouchUpInside];
        view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        self.backGroundView.alpha = 0;
        
        
    }
    return self;
    
    
    
}

- (void)backGroundViewDidClick{
    
    [self close];
    
}

#pragma mark - Actions
- (void)show
{
    
    _isShow = YES;
    [self.rootView addSubview:self.backGroundView];
    [self.rootView addSubview:self];
    self.backGroundView.alpha = 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.backGroundView.alpha = 1;
    }];
    
}

- (void)close
{
    
    _isShow = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.backGroundView.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.backGroundView removeFromSuperview];
    }];
}

@end
