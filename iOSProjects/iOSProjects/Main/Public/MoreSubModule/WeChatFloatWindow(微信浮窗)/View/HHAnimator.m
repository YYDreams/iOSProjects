//
//  HHAnimator.m
//  iOSProjects
//
//  Created by flowerflower on 2018/9/17.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHAnimator.h"
#import "HHAnimatorView.h"
@implementation HHAnimator
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    
    return 1.f;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
//transitionContext: fromView、 fromViewController、 toView、toViewController containerView
    // A控制器  跳转到  B控制器
    
    //fromView A控制器的View   toView：B控制器的View
    
    UIView *containerView = transitionContext.containerView;
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [containerView addSubview:toView];
    
    HHAnimatorView *animatorView = [[HHAnimatorView alloc]initWithFrame:toView.bounds];
    [containerView addSubview:animatorView];
    
    //截屏
    UIGraphicsBeginImageContext(toView.frame.size);
    [toView.layer renderInContext:UIGraphicsGetCurrentContext()];
    animatorView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    toView.hidden = YES;
    
    //animatorView  他是从floatingBtn当前的frame  展开到toView.fram
    [animatorView startAnimateWithView:toView fromRect:_currentFrame toRect:toView.frame];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [transitionContext completeTransition:YES]; //移除fromView/formViewController

    });
    
    
    //
    
    
    
    
}
@end
