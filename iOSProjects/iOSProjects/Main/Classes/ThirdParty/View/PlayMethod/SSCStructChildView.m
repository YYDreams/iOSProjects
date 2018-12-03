//
//  SSCStructChildView.m
//  iOSProjects
//
//  Created by funtSui on 2018/11/28.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "SSCStructChildView.h"
#import "NSUserDefaults+SSC.h"
@interface SSCStructChildView()

@property(nonatomic,strong)UIScrollView  *scrollView;

@property(nonatomic,strong)UIView *lineView;
@end
@implementation SSCStructChildView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubView];
    }
    return self;
    
}

//设置默认为选中第一个
- (SSCChildModel *)getDefaultPlaySon{
    
    NSString *playSonId = [NSUserDefaults sscPlaySonIdByLotteryId:self.lotteryId];
    
    
    for (SSCChildModel *model in self.dataArr) {
        
        if ([model.plid isEqualToString:playSonId]) {
            
            return model;
        }
    }
    return self.dataArr.firstObject;
}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    if (dataArr.count == 0) {
        return;
    }
    
    for(UIView *view in self.scrollView.subviews){
        if (view != self.lineView) {
            [view removeFromSuperview];
        }
    }
    SSCChildModel *defaultModel = [self getDefaultPlaySon];

    SSCPlaySonButton *defaultButton;

    
    CGFloat w = Screen_Width / 4;
    for (int i  = 0 ; i < dataArr.count; i++) {
        
        SSCChildModel *model = self.dataArr[i];

        SSCPlaySonButton *btn =  [[SSCPlaySonButton alloc]init];
        btn.model = model;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

        btn.frame = CGRectMake(i * w , 0, w, self.height);
        
        [self.scrollView addSubview:btn];
        
        if (model == defaultModel) {
            btn.selected = true;
            defaultButton = btn;
        }
    }
        self.scrollView.contentSize = CGSizeMake(self.dataArr.count * w, self.height);
        
        CGSize size = [defaultButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:defaultButton.titleLabel.font}];
        
        self.lineView.frame = CGRectMake(defaultButton.center.x - size.width/2 , self.scrollView.bounds.size.height - 2, size.width, 2);
        
        [self btnAction:defaultButton];


   
    
}
- (void)btnAction:(SSCPlaySonButton *)button{
    
    //先将所有的按钮都设置未不选中状态
    for(UIView *view in self.scrollView.subviews ){
        if ([view isKindOfClass:[SSCPlaySonButton class]]) {
            UIButton *noSelectButton = (UIButton *)view;
            noSelectButton.selected = false;
        }
    }
    //当前点击的按钮设置为选中
    button.selected = true;
    _childModel = button.model;
    // 点击时自移动 到中心位置
    if (button.centerX > self.scrollView.width/2 && (button.centerX <= self.scrollView.contentSize.width - self.scrollView.width/2)) {
        [self.scrollView setContentOffset:CGPointMake(button.centerX - (self.width/2), 0) animated:YES];
    }
    else if(button.centerX > self.scrollView.width/2 && (button.centerX >= self.scrollView.contentSize.width - self.scrollView.width/2)){
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.contentSize.width - self.scrollView.width, 0, self.scrollView.width, self.scrollView.height) animated:true];
    }
    else if(button.centerX <= self.scrollView.width/2){
        [self.scrollView scrollRectToVisible:CGRectMake(0, 0, self.scrollView.width, self.scrollView.height) animated:true];
    }
    
    //底线位置移动判断
    [UIView animateWithDuration:0.2 animations:^{
        CGSize size = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}];
        CGRect frame = CGRectMake(button.center.x - size.width/2 , self.scrollView.bounds.size.height - 2, size.width, 2);
        self.lineView.frame = frame;
    }];
    
    
    if (_handlerChildSelectCallBack) {
        _handlerChildSelectCallBack(_childModel);
    }
    
    [NSUserDefaults sscSavePlaySonId:self.childModel.plid byLotteryId:self.lotteryId];

    
    
}
- (void)setChildModel:(SSCChildModel * _Nonnull)childModel{
    _childModel = childModel;
    
    for (UIView *view in self.scrollView.subviews) {
        
        if ([view isKindOfClass:[SSCPlaySonButton class]]) {
            SSCPlaySonButton *palyButton = (SSCPlaySonButton *)view;
            if (palyButton.model == childModel) {
                [self btnAction:palyButton];
            }
        }
    }
    
}
- (void)setupSubView{
    
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.lineView];
    
}

- (UIScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.scrollEnabled = true;
        _scrollView.backgroundColor = kBgColor;
        _scrollView.alwaysBounceHorizontal = true; //控制水平方向遇到边框是否反弹
        _scrollView.showsHorizontalScrollIndicator = false;
    }
    return _scrollView;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kThemeColor;
    }
    return _lineView;
    
}
@end

@implementation SSCPlaySonButton

- (void)setModel:(SSCChildModel *)model{
    
    _model = model;
    [self setTitle:model.nm forState:UIControlStateNormal];
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.adjustsFontSizeToFitWidth = true;
}
@end



