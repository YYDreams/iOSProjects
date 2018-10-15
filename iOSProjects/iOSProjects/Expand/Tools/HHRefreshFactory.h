//
//  HHRefreshFactory.h
//  leyingyinggame
//
//  Created by TuMi on 2016/11/19.
//  Copyright © 2016年 TuMi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MJRefreshHeader;
@class MJRefreshFooter;

@interface HHRefreshFactory : NSObject

+ (MJRefreshHeader *)headerRefreshWithTarget:(id)target refreshingAction:(SEL)action;

+ (MJRefreshFooter *)footerRefreshWithTarget:(id)target refreshingAction:(SEL)action;

@end
