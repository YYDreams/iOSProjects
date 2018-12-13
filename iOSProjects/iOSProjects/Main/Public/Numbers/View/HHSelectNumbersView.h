//
//  HHSelectNumbersView.h
//  iOSProjects
//
//  Created by funtSui on 2018/12/12.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHSelectNumbersView : UIView



@property(nonatomic,assign)NSInteger index; //选项卡ABCDE


@property(nonatomic,copy)void(^handlerSlectNumberBtnCallBack)(void);

@end
