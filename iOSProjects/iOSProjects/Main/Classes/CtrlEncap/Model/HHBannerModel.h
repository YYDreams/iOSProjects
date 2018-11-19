//
//  HHBannerModel.h
//  iOSProjects
//
//  Created by flowerflower on 2018/11/19.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "BaseModel.h"

@interface HHBannerModel : BaseModel
@property (nonatomic, strong) NSString * pic;
@property (nonatomic, strong) NSString * link;
@property (nonatomic, strong) NSString * link_type;//类型1外部，2活动
@property (nonatomic, strong) NSString * active_id;//活动id

@property (nonatomic, strong) NSString *pic_img;

@end
