//
//  HHAnimatorView.h
//  iOSProjects
//
//  Created by flowerflower on 2018/9/17.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHAnimatorView : UIImageView

- (void)startAnimateWithView:(UIView *)toView fromRect:(CGRect)fromRect toRect:(CGRect)toRect;

@end
