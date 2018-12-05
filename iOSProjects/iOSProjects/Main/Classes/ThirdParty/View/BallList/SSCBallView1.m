//
//  SSCBallView1.m
//  iOSProjects
//
//  Created by funtSui on 2018/12/5.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "SSCBallView1.h"

@interface SSCBallView1()

@property(nonatomic,strong)UILabel *titleLabel;
@end
@implementation SSCBallView1

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubView];
    }
    
    return self;
    
}

- (void)setupSubView{
    
    {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        label.backgroundColor = [UIColor clearColor];
        label.layer.borderWidth = 0.5;
        label.layer.borderColor = kThemeColor.CGColor;
        [self addSubview:label];
        self.titleLabel = label;
    }
    
    self.userInteractionEnabled = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
    
}

- (void)setModel:(SSCBallViewModel *)model{
    
    _model = model;
    
    self.titleLabel.text = model.number;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.titleLabel.width;
    self.titleLabel.centerX = self.width/2;
    self.titleLabel.top = 0;
    self.titleLabel.layer.borderWidth = 1;
    self.titleLabel.layer.cornerRadius = self.titleLabel.width/2;
    self.titleLabel.layer.masksToBounds = true;
    
    self.isSelect = model.isSelect;
    
}
- (void)tapAction{
    
    self.isSelect = ! self.isSelect;
    
    
    self.didChangeStatus(self.isSelect);
}

- (void)setIsSelect:(BOOL)isSelect{
    
    _isSelect = isSelect;
    
    
    if (_isSelect) {
        
        self.titleLabel.backgroundColor =kThemeColor;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = kThemeColor;
    }else{
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor = kThemeColor;
        self.titleLabel.backgroundColor = [UIColor whiteColor];
    }
    
    
}
@end
