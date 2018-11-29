//
//  SSCStructModel.m
//  iOSProjects
//
//  Created by funtSui on 2018/11/28.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "SSCStructModel.h"

@implementation SSCStructModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"standard" : @"SSCSuperModel",
             @"fast" : @"SSCSuperModel"
             };
}
@end

@implementation SSCSuperModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"child" : @"SSCChildModel",
             };
}
@end

@implementation SSCChildModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"tags" : @"SSCTagsModel",
             };
}
@end

@implementation SSCTagsModel

@end
@implementation SSCPlayTypeModel

@end

