//
//  HHAnimator.h
//  iOSProjects
//
//  Created by flowerflower on 2018/9/17.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHAnimator : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic,assign)CGRect currentFrame;
@end
