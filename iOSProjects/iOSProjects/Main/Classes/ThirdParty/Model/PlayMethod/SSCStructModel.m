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

-(void)setChildPlayType{
    NSString * path  = [[NSBundle mainBundle] pathForResource:@"PlayType.plist" ofType:nil];
    NSDictionary *root = [[NSDictionary alloc] initWithContentsOfFile:path];
    for (SSCSuperModel *sup in self.standard) {
        for (SSCChildModel *chi in sup.child) {
            chi.type = [SSCPlayTypeModel yy_modelWithDictionary:root[chi.plid]];
            if(!chi.type){
                chi.type = [SSCPlayTypeModel yy_modelWithDictionary:root[@"0"]];
            }
        }
    }
    for (SSCSuperModel *sup in self.fast) {
        for (SSCChildModel *chi in sup.child) {
            chi.type = [SSCPlayTypeModel yy_modelWithDictionary:root[chi.plid]];
            if(!chi.type){
                chi.type = [SSCPlayTypeModel yy_modelWithDictionary:root[@"0"]];
            }
        }
    }
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

