//
//  FSPlayAlertView.h
//  iOSProjects
//
//  Created by funtSui on 2018/12/14.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,FSPlayType){
    FSPlayTypeLoTo, //乐透
    FSPlayTypeNumber, // numbers3
    
};
@interface FSPlayAlertView : UIView


+ (instancetype)showPlayType:(FSPlayType)type;

@end
