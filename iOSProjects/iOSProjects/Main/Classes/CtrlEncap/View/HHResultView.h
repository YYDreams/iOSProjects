//
//  HHResultView.h
//  iOSProjects
//
//  Created by flowerflower on 2018/11/15.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,HHResultViewType){ //收货地址
    HHResultViewTypeSymbol, // (圆球 + 符号(+ =))
    HHResultViewTypePellet, // 圆球
    HHResultViewTypeDice,  // 🎲
    HHResultViewTypePelletColor, //普通圆球加对应颜色
    
};

@interface HHResultView : UIView

@property (nonatomic,assign)NSInteger maxNumber;


- (void)addNumbers:(NSArray *)numbers result:(NSString *)result type:(HHResultViewType)type;

@end
