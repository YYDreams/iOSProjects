//
//  SSCCellContentView3.m
//  iOSProjects
//
//  Created by funtSui on 2018/12/5.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "SSCCellContentView3.h"
#import "SSCBallView1.h"

#define kTagZone3 2000


@interface SSCCellContentView3()


@property (nonatomic,strong)UIImageView *titleBgView;
@property (nonatomic,strong)UILabel *titleLabel;

@end
@implementation SSCCellContentView3



- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubView];
        
    }
    return self;
    
}
- (void)setModel:(SSCBallCellModel *)model{
    
    _model = model;
    
    /**
     
     -layoutSubviews方法：这个方法，默认没有做任何事情，需要子类进行重写
     -setNeedsLayout方法： 标记为需要重新布局，异步调用layoutIfNeeded刷新布局，不立即刷新，但layoutSubviews一定会被调用
     -layoutIfNeeded方法：如果，有需要刷新的标记，立即调用layoutSubviews进行布局（如果没有标记，不会调用layoutSubviews）
     
     */
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    NSArray *subViews = self.subviews;
    for(UIView *view in subViews){
        if([view isKindOfClass:[SSCBallView1 class]]){
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
    CGFloat x = 25;
    CGFloat y = self.titleBgView.bottom + 20;
    CGFloat w = (self.width - 5*s - 2*x)/6;
    CGFloat h = 45;
    
    for (int i = 0; i < self.model.ballArray.count; i++) {
        SSCBallView1 *ball = [self viewWithTag:kTagZone3 + i];
//        ball.frame =  CGRectMake(s + (s + w) * (i % 6), y + (s+ w) * (i / 6), w, h);  //有问题
        ball.frame = CGRectMake(x, y, w, h);
        
        ball.hidden = false;
        ball.model = self.model.ballArray[i];
        
        x = ball.right + s;
        y = ball.top;
        if(x >= self.width - ball.width){
            y = ball.bottom + 10;
            x = 25;
        }
    }
    
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
    
    
    
    for (int i = 0; i < 50; i ++ ) {
        
        WeakSelf;
        //        __weak typeof(self) weakSelf = self;
        SSCBallView1 *ball = [[SSCBallView1 alloc]initWithFrame:CGRectZero];
        
        ball.didChangeStatus = ^(BOOL isSelect){
            NSLog(@"isSelect=========%d",isSelect);
                [weakSelf seletectBallDidChange];
        };
        ball.tag = kTagZone3 + i;
        ball.hidden = true;
        [self addSubview:ball];
        
        
    }
    
    
}
- (void)seletectBallDidChange{
    
    NSMutableArray *arr = [NSMutableArray array];
    

    for (UIView *view  in self.subviews) {
        if ([view isKindOfClass:[SSCBallView1 class]] && view.hidden == false) {
            SSCBallView1 *ballView1 = (SSCBallView1 *)view;
            if (ballView1.isSelect) {
                
                [arr addObject:ballView1.model.commit];
            }
        }
    }
    
    self.didChangeSelectBall(arr);
    
}

+ (CGFloat)getHeight :(SSCBallCellModel *)model{
    
    CGFloat totalHeight = (model.ballArray.count /6 + 1) * 55 + 40;
    
    if (model.ballArray.count % 6 == 0 ) {
        
        totalHeight -= 55;
    }
    return totalHeight;
}


@end
