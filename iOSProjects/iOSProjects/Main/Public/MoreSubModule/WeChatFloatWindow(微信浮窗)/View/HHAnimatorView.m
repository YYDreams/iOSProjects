
//
//  HHAnimatorView.m
//  iOSProjects
//
//  Created by flowerflower on 2018/9/17.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHAnimatorView.h"

@interface HHAnimatorView()<CAAnimationDelegate>{
    
    CAShapeLayer *_shapeLayer;
    UIView *_toView;
    
}
@end
@implementation HHAnimatorView

- (void)startAnimateWithView:(UIView *)toView fromRect:(CGRect)fromRect toRect:(CGRect)toRect{
    
//fromRect: 表示和folatingBtn的rect一致
    _toView = toView;
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:fromRect cornerRadius:30.f].CGPath;
    self.layer.mask = _shapeLayer;
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.toValue = (__bridge id)[UIBezierPath bezierPathWithRoundedRect:toRect cornerRadius:30.f].CGPath;
    animation.duration = 0.5f;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    [_shapeLayer addAnimation:animation forKey:nil];
    
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    

    _toView.hidden = NO;
    [_shapeLayer removeAllAnimations];
    [self removeFromSuperview];
}
@end
