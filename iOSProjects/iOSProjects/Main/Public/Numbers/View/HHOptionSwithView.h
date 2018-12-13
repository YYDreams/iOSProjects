//
//  HHOptionSwithView.h
//  iOSProjects
//
//  Created by funtSui on 2018/12/12.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>


//标签状态
typedef NS_ENUM(NSInteger,HHOptionSwithViewStatus){
    
    HHOptionSwithViewStatusNotSelect, //未选择状态
    HHOptionSwithViewStatusSelected, //已选状态
    HHOptionSwithViewStatusCurrent, //当前状态
};


@interface HHOptionSwithView : UIView


@property(nonatomic,copy)NSArray *itemsArr;

@property(nonatomic,copy)void(^itemHandlerOnClick)(NSInteger index);

-(void)setSelectAtIndex:(NSInteger)index;


//
- (void)setOptionStatus:(HHOptionSwithViewStatus)status;


@end
