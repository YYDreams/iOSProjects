//
//  SSCBallsView.h
//  iOSProjects
//
//  Created by funtSui on 2018/12/4.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSCStructModel.h"
@interface SSCBallsView : UIView



@property(nonatomic,strong)SSCChildModel *childModel;

@property (nonatomic,strong)NSString *pid;//父彩种id

@property (nonatomic,strong)NSMutableDictionary *selectBallDict;//选中的球号


- (void)randomBall;

- (void)resetListView;

@end
