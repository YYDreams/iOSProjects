//
//  SSCBallView2.m
//  iOSProjects
//
//  Created by funtSui on 2018/12/6.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "SSCBallView2.h"
@interface SSCBallView2()
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;
@end
@implementation SSCBallView2

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubView];
    }
    return self;
}

- (void)setModel:(SSCBallViewModel *)model{
    
    _model = model;
    if(model.odds){
        
        if (!model.tp) {
            self.label1.text = model.number;
            [self.label1 sizeToFit];
            if (self.label1.width > self.width - 5) {
                self.label1.width = self.width - 5;
            }
            self.label1.centerX = self.width/2;
            self.label1.bottom = self.height/2 + 1;
            
            self.label2.text = [NSString stringWithFormat:@"赔率:%@",model.odds];
            [self.label2 sizeToFit];
            if (self.label2.width > self.width - 5) {
                self.label2.width = self.width - 5;
            }
            self.label2.centerX = self.width/2;
            self.label2.top = self.height/2 + 3;
            
            self.label2.hidden = false;
            self.label3.hidden = true;
        }else {
            
            self.label1.text = model.number;
            [self.label1 sizeToFit];
            if (self.label1.width > self.width - 5) {
                self.label1.width = self.width - 5;
            }
            self.label1.centerX = self.width/2;
            self.label1.bottom = self.height/3 + 2;
            
            self.label2.text = [NSString stringWithFormat:@"赔率:%@",model.odds];
            [self.label2 sizeToFit];
            if (self.label2.width > self.width - 5) {
                self.label2.width = self.width - 5;
            }
            self.label2.centerX = self.width/2;
            self.label2.top = self.height/3 + 2;
            self.label2.bottom = self.height/3 * 2;
            self.label2.hidden = false;
            
            self.label3.text = model.tp;
            [self.label3 sizeToFit];
            if (self.label3.width > self.width - 5) {
                self.label3.width = self.width - 5;
            }
            self.label3.centerX = self.width/2;
            self.label3.top = self.height/3 * 2;
            self.label3.hidden = false;
        }
        
    }
    else{
        self.label1.text = model.number;
        [self.label1 sizeToFit];
        if (self.label1.width > self.width - 5) {
            self.label1.width = self.width - 5;
        }
        self.label1.centerX = self.width/2;
        self.label1.centerY = self.height/2;
        
        self.label2.hidden = true;
        self.label3.hidden = true;
    }
    
    self.isSelected = model.isSelect;

    
    
}
- (void)setIsSelected:(BOOL)isSelected{
    
    _isSelected = isSelected;
    
    if (isSelected) {
    
        self.backgroundColor = kThemeColor;
        
        self.label1.textColor = [UIColor whiteColor];
        self.label2.textColor = [UIColor whiteColor];
        self.label3.textColor = [UIColor whiteColor];
    }else{
        
        self.backgroundColor = [UIColor whiteColor];
        self.label1.textColor = [self getLabel2Color];
        self.label2.textColor = kRedColor;
        self.label3.textColor = [UIColor lightGrayColor];
        
    }
    
}

- (UIColor *)getLabel2Color{
    
    if ([self.model.number containsString:@"红"]) {
        return [UIColor colorWithHexString:@"ff4e4e"];
    }else if ([self.model.number containsString:@"蓝"]){
        return [UIColor colorWithHexString:@"5196f5"];
    }else if ([self.model.number containsString:@"绿"]){
        return [UIColor colorWithHexString:@"4fd3a9"];

    }else {
        return [UIColor lightGrayColor];
    }
    
}

- (void)setupSubView{
    
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:14];
        label.adjustsFontSizeToFitWidth = true;
        label.backgroundColor = [UIColor clearColor];
        label.adjustsFontSizeToFitWidth = true;
        [self addSubview:label];
        self.label1 = label;
    }
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = kRedColor;
        label.font = [UIFont systemFontOfSize:11];
        label.adjustsFontSizeToFitWidth = true;
        label.backgroundColor = [UIColor clearColor];
        label.adjustsFontSizeToFitWidth = true;
        [self addSubview:label];
        self.label2 = label;
    }
    
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:10];
        label.adjustsFontSizeToFitWidth = true;
        label.backgroundColor = [UIColor clearColor];
        label.adjustsFontSizeToFitWidth = true;
        [self addSubview:label];
        self.label3 = label;
    }
    
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 5;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.userInteractionEnabled = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
    
}

- (void)tapAction{
    self.isSelected = !self.isSelected;
    self.didChangeStatus(self.isSelected);
}


@end
