//
//  HHOptionSwithView.h
//  iOSProjects
//
//  Created by funtSui on 2018/12/12.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHOptionSwithView : UIView


@property(nonatomic,copy)NSArray *itemsArr;

@property(nonatomic,copy)void(^itemHandlerOnClick)(NSInteger index);

-(void)setSelectAtIndex:(NSInteger)index;



@end
