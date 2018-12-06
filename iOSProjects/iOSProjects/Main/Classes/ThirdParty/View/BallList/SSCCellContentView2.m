
//
//  SSCCellContentView2.m
//  iOSProjects
//
//  Created by funtSui on 2018/12/5.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "SSCCellContentView2.h"

@implementation SSCCellContentView2

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubView];
        
    }
    return self;
    
}
- (void)setupSubView{
    
}

+ (CGFloat)getHeight :(SSCBallCellModel *)model{
    
    return 200;
}

@end
