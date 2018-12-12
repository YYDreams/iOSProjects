//
//  KZWSuspensionButton.m
//  iOSProjects
//
//  Created by funtSui on 2018/12/11.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "KZWSuspensionButton.h"

@implementation KZWSuspensionButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];//创建手势
        [self setUserInteractionEnabled:YES];
        [self addTarget:self action:@selector(btnOnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addGestureRecognizer:pan];
    }
    return self;
}

- (void)btnOnClick{
    
    NSLog(@"%s",__func__);
    
}
- (void)handlePan: (UIPanGestureRecognizer *)rec{
    
    CGPoint point = [rec translationInView:[UIApplication sharedApplication].keyWindow];
    
    NSLog(@"========%f,%f",point.x,point.y);
    
    rec.view.center = CGPointMake(rec.view.center.x + point.x, rec.view.center.y + point.y);
    
    [rec setTranslation:CGPointZero inView:[UIApplication sharedApplication].keyWindow];
    
    if (rec.state == UIGestureRecognizerStateEnded) {
        if (self.frame.origin.x < Screen_Width/2) {
            [self viewMove:rec.view point:CGPointMake(20 , rec.view.center.y + point.y)];
            if (self.frame.origin.y < kNavHeight ) {
                NSLog(@"++++++++++");
                [self viewMove:rec.view point:CGPointMake(20 , kNavHeight + 20)];
            }
            if (self.frame.origin.y > Screen_Height - kTabBarHeight) {
                NSLog(@"----------");
                [self viewMove:rec.view point:CGPointMake(20 , Screen_Height - kTabBarHeight - 20)];
            }
        }else {
            [self viewMove:rec.view point:CGPointMake(Screen_Width - 20 , rec.view.center.y + point.y)];
            if (self.frame.origin.y < kNavHeight ) {
                NSLog(@"************");
                [self viewMove:rec.view point:CGPointMake(Screen_Width - 20 , kNavHeight + 20)];
            }
            if (self.frame.origin.y > Screen_Height - kTabBarHeight) {
                NSLog(@"//////////////");
                [self viewMove:rec.view point:CGPointMake(Screen_Width - 20 , Screen_Height - kTabBarHeight - 20)];
            }
        }
    }
}

- (void)viewMove:(UIView *)view point:(CGPoint)point {
    [UIView animateWithDuration:0.6
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         view.center = point;
                     }
                     completion:nil];
}



@end
