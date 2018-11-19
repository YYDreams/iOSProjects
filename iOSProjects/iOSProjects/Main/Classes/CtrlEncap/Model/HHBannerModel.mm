//
//  HHBannerModel.m
//  iOSProjects
//
//  Created by flowerflower on 2018/11/19.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHBannerModel.h"
#import <WCDB/WCDB.h>
@interface HHBannerModel()<WCTTableCoding>

WCDB_PROPERTY(pic)
WCDB_PROPERTY(link)

@end
@implementation HHBannerModel

WCDB_IMPLEMENTATION(HHBannerModel)
WCDB_SYNTHESIZE(HHBannerModel, pic)
WCDB_SYNTHESIZE(HHBannerModel, link)

WCDB_PRIMARY(HHBannerModel, pic)


+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"pic_img":@"pic"};
}
@end
