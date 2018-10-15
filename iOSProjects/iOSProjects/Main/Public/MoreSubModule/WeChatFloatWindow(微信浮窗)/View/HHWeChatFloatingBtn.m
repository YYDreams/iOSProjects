//
//  HHWeChatFloatingBtn.m
//  iOSProjects
//
//  Created by flowerflower on 2018/9/16.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHWeChatFloatingBtn.h"
#import "HHSemCircleView.h"
#import "Test1ViewController.h"
#import "HHAnimator.h"
@interface HHWeChatFloatingBtn()<UINavigationControllerDelegate>{
    
    CGPoint lastPoint;
    CGPoint pointInself;
}




@end
@implementation HHWeChatFloatingBtn
static HHWeChatFloatingBtn *floatingBtn;
static HHSemCircleView *semCircleView;

/**
 只要floatingBtn移动了 则semCircleView以动态的形式显示出来
 */
#define fixedSpace 160.f
+ (void)show{
    
    /* 静态变量: 生命周期和App的生命周期是一样的*/
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        floatingBtn = [[self alloc]initWithFrame:CGRectMake(10, 200, 60, 60)];

        semCircleView = [[HHSemCircleView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, fixedSpace, fixedSpace)];
        
        semCircleView.backgroundColor = [UIColor redColor];
    });
//    注意: 需要先添加semCircleView  floatingBtn要始终保持在最上面一层
    //
    if (!semCircleView.superview) {
       
        [[UIApplication sharedApplication].keyWindow addSubview:semCircleView];

        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:semCircleView];
        
    }
    
    //判断
    if (!floatingBtn.superview) {
        
        [[UIApplication sharedApplication].keyWindow addSubview:floatingBtn];
        
        //注意: 在任何界面在最上层
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:floatingBtn];
    }

}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self  = [super initWithFrame:frame];
    //在View上添加图片
    self.layer.contents = (__bridge id)[UIImage imageNamed:@"login"].CGImage;

    return self;
    
}
/**
 1. 点击效果->拖动 ->
 touchesBegan 标记坐标
 touchesBegan 和 touchesEnded 相等  表示 点击
 
 
 touchesMoved：
 
 
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.superview];
    pointInself = [touch locationInView:self];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.superview];
    
    //计算出来floatingBtn的center坐标
    CGFloat centerX = currentPoint.x + (self.frame.size.width/2 - pointInself.x);
    CGFloat centerY = currentPoint.y + (self.frame.size.height/2 - pointInself.y);
    
    
    CGFloat x = MAX(30, MIN([UIScreen mainScreen].bounds.size.width-30, centerX));
    CGFloat y = MAX(30, MIN([UIScreen mainScreen].bounds.size.height-30, centerY));
    
    
    self.center = CGPointMake(x, y);
    
    
    if (CGRectEqualToRect(semCircleView.frame, CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, fixedSpace, fixedSpace))) {
        semCircleView.frame =CGRectMake( [UIScreen mainScreen].bounds.size.width - fixedSpace, [UIScreen mainScreen].bounds.size.height - fixedSpace, fixedSpace, fixedSpace);

    }
 
    
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.superview];
    //
    if (CGPointEqualToPoint(lastPoint, currentPoint)) {
        UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        nav.delegate = self;
      Test1ViewController *nextVc  =  [Test1ViewController new];
        [nav pushViewController:nextVc animated:YES];
        
        //点击效果
        return;
    }
    
    //    if (CGRectEqualToRect(semCircleView.frame, CGRectMake( [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, fixedSpace, fixedSpace))) {
    
    
    [UIView animateWithDuration:0.2f animations:^{
        
        /**
         
         根号 （X2 - X1）^2 + (Y2 - Y1)^2
         */
        
        CGFloat distance = sqrt(pow([UIScreen mainScreen].bounds.size.width - self.center.x, 2) + pow([UIScreen mainScreen].bounds.size.height -self.center.y, 2));
        
        
        //连个圆心的距离 <= 两个半径只差 说明了floatingBtn在semCircleView内部，则移除
        if (distance <=  fixedSpace - 30.f) {
            
            [self removeFromSuperview];
        }
        
        semCircleView.frame = CGRectMake( [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, fixedSpace, fixedSpace);
    }];
    
    //
    
    //靠左还是靠右
    
    CGFloat leftMargin = self.center.x;
    CGFloat rightMargin = [UIScreen mainScreen].bounds.size.width - leftMargin;
    
    
    if (leftMargin < rightMargin) {
        
        [UIView animateWithDuration:0.2f animations:^{
           
            self.center = CGPointMake(40.f, self.center.y);
        }];
        
    }else{
        
        [UIView animateWithDuration:0.2f animations:^{
            self.center = CGPointMake([UIScreen mainScreen].bounds.size.width - 40.f, self.center.y);

        }];
        
    }
    
    

}
#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
        
        HHAnimator *animator = [[HHAnimator alloc]init];
        animator.currentFrame = self.frame;
        return animator;
    }
    
    return nil;
    
}
//转场动画的时间   转场动画的实际操作和效果







@end
