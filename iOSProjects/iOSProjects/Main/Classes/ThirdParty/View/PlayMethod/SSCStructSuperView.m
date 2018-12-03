//
//  SSCStructSuperView.m
//  iOSProjects
//
//  Created by funtSui on 2018/11/28.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "SSCStructSuperView.h"
#import "NSUserDefaults+SSC.h"
#define kTagZone 100

@interface SSCStructSuperView()

@property (nonatomic,strong)UIView *whiteView;//白色页面

@property (nonatomic,strong)NSArray *standardArray;//标准

@property (nonatomic,strong)NSArray *fastArray;//快捷

@property(nonatomic,strong)UIView *bgView;

@end
@implementation SSCStructSuperView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        UIView *bgView = [[UIView alloc]initWithFrame:self.bounds];
        bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [bgView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)]];
        [self addSubview:bgView];
        
        UIView *whiteView = [[UIView alloc]initWithFrame:self.bounds];
        whiteView.backgroundColor = [UIColor whiteColor];
        self.whiteView = whiteView;
        [self addSubview:whiteView];
        
        self.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
    
}
- (void)showInView:(UIView *)view{
    
    [view addSubview:self];
    
    self.alpha = 0;
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
        
    }];
    
}

- (void)tapAction{
    
    if (_handlerStructSuperBgCallBack) {
        _handlerStructSuperBgCallBack();
    }
    [self removeFromSuperview];
    
    
}

- (void)close{

    [self removeFromSuperview];
}

- (void)btnOnClick:(SSCPlayMethodButton *)btn{
    
    for (UIView *view in self.whiteView.subviews) {
        
        if (![view isKindOfClass:[UIButton class]]) {
            
            continue;
        }
        
        SSCPlayMethodButton *button = (SSCPlayMethodButton *)view;
        
        if (button == btn) {
            button.selected = true;
        }else{
            button.selected = false;

        }
    }
    
    _superModel = btn.model;

//    if (_handlerItemDidSelectCallBack) {
//        _handlerItemDidSelectCallBack(btn.type,_superModel);
//    }
    
    [self.delegate structSuperView:self didSelectType:btn.type SuperModel:_superModel];

    
    [self removeFromSuperview];
    
    [NSUserDefaults savePlayType:[NSString stringWithFormat:@"%ld",btn.type] byLotteryId:_lotteryId];
    
    [NSUserDefaults sscSavePlayId:btn.model.nm byLotteryId:self.lotteryId];
    
    
}


//设置数据源
- (void)setStandardMehtods:(NSArray <SSCSuperModel*>*)standardArray fastMethods:(NSArray <SSCSuperModel*>*)fastArray{
    
    _standardArray = standardArray;
    _fastArray = fastArray;
    
    NSArray *subViews = self.whiteView.subviews;
    
    NSLog(@"%@====subViews====",subViews);
    for(UIView *view in subViews){
        [view removeFromSuperview];
    }
    
    _superModel = [self getDefalutPlayMethod];

    SSCPlayType type = SSCPlayType_Standard;
    
    
    CGFloat totalHeight = 10;
    if (standardArray.count > 0) {
        UILabel *label = [[UILabel alloc] init];
        label.text = @"— 标准玩法 —";
        label.textColor = kThemeColor;
        label.font = [UIFont boldSystemFontOfSize:15 ];
        [label sizeToFit];
        label.top = totalHeight;
        label.centerX = self.width/2;
        [self.whiteView addSubview:label];
        
        CGFloat separate = 12;
        CGFloat x = separate;
        CGFloat y = label.bottom + 10;
        CGFloat w = ([UIScreen mainScreen].bounds.size.width - 5*separate)/4;
        CGFloat h = 35;
        for (int i = 0; i < standardArray.count; i++) {
            SSCSuperModel *model = standardArray[i];
            SSCPlayMethodButton *button = [[SSCPlayMethodButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
            button.tag = kTagZone + i;
            button.model = model;
            button.type = SSCPlayType_Standard;
            [button addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.whiteView addSubview:button];
            if (model == _superModel) {
                button.selected = true;
                type = SSCPlayType_Standard;
            }
            
            totalHeight = button.bottom;
            x = button.right + separate;
            if (x + w > self.width) {
                x = separate;
                y = button.bottom + separate;
            }
        }
        self.whiteView.height = totalHeight + 15;
    }
    
    if (fastArray.count > 0) {
        UILabel *label = [[UILabel alloc] init];
        label.text = @"— 快捷玩法 —";
        label.textColor = kThemeColor;
        label.font = [UIFont boldSystemFontOfSize:15 ];
        [label sizeToFit];
        label.top = totalHeight + 10;
        label.centerX = self.width/2;
        [self.whiteView addSubview:label];
        
        CGFloat separate = 12;
        CGFloat x = separate;
        CGFloat y = label.bottom + 10;
        CGFloat w = ([UIScreen mainScreen].bounds.size.width - 5*separate)/4;
        CGFloat h = 35;
        for (int i = 0; i < fastArray.count; i++) {
            SSCSuperModel *model = fastArray[i];
            SSCPlayMethodButton *button = [[SSCPlayMethodButton alloc]initWithFrame:CGRectMake(x, y, w, h)];
            button.tag = kTagZone + i;
            button.model = model;
            button.type = SSCPlayType_Fast;
            [button addTarget:self action:@selector(btnOnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.whiteView addSubview:button];
            if (model == _superModel) {
                button.selected = true;
                type = SSCPlayType_Fast;
            }
            
            totalHeight = button.bottom;
            
            x = button.right + separate;
            if (x + w > self.width) {
                x = separate;
                y = button.bottom + separate;
            }
        }
        self.whiteView.height = totalHeight + 15;
    }
    
    [self.delegate structSuperView:self didSelectType:type SuperModel:_superModel];

    if (_handlerItemDidSelectCallBack) {
        _handlerItemDidSelectCallBack(type,_superModel);
    }

}


- (SSCSuperModel *)getDefalutPlayMethod{
    
    NSString * playId = [NSUserDefaults sscPlayIdByLotteryId:self.lotteryId];
    NSString *playType = [NSUserDefaults playTypeByLotteryId:self.lotteryId];
    
    if (playType.integerValue == SSCPlayType_Standard) {
        
        for (SSCSuperModel *model in self.standardArray) {
            if ([model.nm isEqualToString:playId]) {
                
                return model;
            }
        }
    }else{
        
        for (SSCSuperModel *model in self.fastArray) {
            if ([model.nm isEqualToString:playId]) {
                
                return model;
            }
        }
        
    }
    
    if (self.standardArray.count > 0) {
        
        return self.standardArray.firstObject;
        
    }else{
        
        return self.fastArray.firstObject;
    }


}




@end



@implementation SSCPlayMethodButton

-(void)setModel:(SSCSuperModel *)model{
    _model = model;
    NSString *text = [NSString stringWithFormat:@"%@(%ld)",model.nm,model.child.count];
    UIColor *normalColor = kThemeColor;
    UIColor *selectColor = [UIColor whiteColor];
    
    UIImage *normalImage = [UIImage imageWithColor:[UIColor whiteColor]];
    UIImage *selectImage = [UIImage imageWithColor:[UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1]];
    
    self.titleLabel.adjustsFontSizeToFitWidth = true;
    [self setTitle:text forState:UIControlStateNormal];
    [self setTitleColor:normalColor forState:UIControlStateNormal];
    [self setTitleColor:normalColor forState:UIControlStateHighlighted];
    [self setTitleColor:selectColor forState:UIControlStateSelected];
    [self setBackgroundImage:normalImage forState:UIControlStateNormal];
    [self setBackgroundImage:selectImage forState:UIControlStateSelected];
    [self setBackgroundImage:normalImage forState:UIControlStateHighlighted];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.layer.cornerRadius = 5;
    self.layer.borderColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.masksToBounds = true;
}


@end


