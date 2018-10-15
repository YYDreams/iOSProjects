//
//  HHRefreshFactory.m
//  leyingyinggame
//
//  Created by TuMi on 2016/11/19.
//  Copyright © 2016年 TuMi. All rights reserved.
//

#import "HHRefreshFactory.h"
#import <MJRefresh.h>

@implementation HHRefreshFactory

+ (MJRefreshHeader *)headerRefreshWithTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
//    header.stateLabel.font = [UIFont systemFontOfSize:10.0];
//    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:10.0];
//    header.arrowView.image = [UIImage imageNamed:@"refreshImage"];
    
    return header;
}

+ (MJRefreshFooter *)footerRefreshWithTarget:(id)target refreshingAction:(SEL)action
{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    //footer.triggerAutomaticallyRefreshPercent = -10;
//    footer.stateLabel.font = [UIFont systemFontOfSize:10.0];
    return footer;
}

@end
