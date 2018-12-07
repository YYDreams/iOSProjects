
//
//  SSCCellContentView2.m
//  iOSProjects
//
//  Created by funtSui on 2018/12/5.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "SSCCellContentView2.h"
#import "SSCBallViewModel.h"
#import "SSCBallView2.h"
#define kTagZone 1000

@interface SSCCellContentView2()

@property (nonatomic,strong)UIImageView *titleBgView;
@property (nonatomic,strong)UILabel *titleLabel;


@end

@implementation SSCCellContentView2

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubView];
        
    }
    return self;
    
}



- (void)setupSubView{
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    //    imageView.image = [[UIImage imageNamed:@"ssc_cell_title_bg_1"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    imageView.backgroundColor = [UIColor grayColor];
    self.titleBgView = imageView;
    [self addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;
    self.titleLabel = label;
    [self.titleBgView addSubview:label];
    
    
    
    for (int i = 0; i < 28; i ++ ) {
        
        WeakSelf;
        //        __weak typeof(self) weakSelf = self;
        SSCBallView2 *ball = [[SSCBallView2 alloc]initWithFrame:CGRectZero];
        
        ball.didChangeStatus = ^(BOOL isSelect){
            NSLog(@"isSelect=========%d",isSelect);
            [weakSelf seletectBallDidChange];
        };
        ball.tag = kTagZone + i;
        ball.hidden = true;
        [self addSubview:ball];
        
        
    }
    
    
}
- (void)seletectBallDidChange{
    
    NSMutableArray *arr = [NSMutableArray array];
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[SSCBallView2 class]] && view.hidden == false) {
            
            SSCBallView2 *ballView2 = (SSCBallView2 *)view;
            
            if (ballView2.isSelected) {
                
                [arr addObject:ballView2.model.commit];

            }
        }
    }
    
    self.didChangeSelectBall(arr);
    
    
}

- (void)setModel:(SSCBallCellModel *)model{
    
    _model = model;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];

}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSArray *subViews = self.subviews;
    for(UIView *view in subViews){
        if([view isKindOfClass:[SSCBallView2 class]]){
            view.hidden = true;
        }
    }
    
    self.titleBgView.width = 70;
    self.titleBgView.height = 20;
    self.titleBgView.left = 0;
    self.titleBgView.top = 0;
    
    self.titleLabel.text = self.model.title;
    [self.titleLabel sizeToFit];
    self.titleLabel.left = 6;
    self.titleLabel.centerY = self.titleBgView.height/2;
    self.titleBgView.width = self.titleLabel.right + 14;
    
    CGFloat s = 20;
    CGFloat x = 15;
    CGFloat y = self.titleBgView.bottom + 20;
    CGFloat w = (self.width - 3*s - 2*x)/4;
    CGFloat h = 50;
    NSArray *ballArray = self.model.ballArray;
    
    for (int i = 0; i < ballArray.count; i++) {
        CGRect rect = CGRectMake(x, y, w, h);
        SSCBallView2 *ball = [self viewWithTag:kTagZone + i];
        ball.frame = rect;
        ball.hidden = false;
        ball.model = ballArray[i];
        
        x = ball.right + s;
        y = ball.top;
        if(x >= self.width - ball.width){
            y = ball.bottom + 15;
            x = 15;
        }
    }
    
}

+ (CGFloat)getHeight :(SSCBallCellModel *)model{
    
    CGFloat ballViewHeight = 65;
    
    SSCBallViewModel *cellModel;
    
    if (model.ballArray.count > 0) {
        
        cellModel = model.ballArray.firstObject;
        
        if (cellModel.tp) {
            ballViewHeight = 70;
        }
    }
//
    CGFloat row = ((model.ballArray.count - 1)/4 + 1);
        CGFloat totalHeight = row * ballViewHeight + 39;
    
//    CGFloat totalHeight = (model.ballArray.count/ 4 + 1) * ballViewHeight + 39 ;
//    if (model.ballArray.count % 4 == 0) {
//        totalHeight -= ballViewHeight;
//    }
    
    NSLog(@"totalHeight = %f",totalHeight);
    
    return totalHeight;
}

@end
