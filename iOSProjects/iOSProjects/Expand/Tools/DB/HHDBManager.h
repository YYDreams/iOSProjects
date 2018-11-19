//
//  HHDBManager.h
//  iOSProjects
//
//  Created by flowerflower on 2018/11/19.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHDBManager : NSObject

//+ (instancetype)shareInstance;

- (instancetype)initWithobjectClass:(Class)objectClass;

- (void)insertObjects:(NSArray *)objects;

- (NSArray *)getAllObjects;


/**
 使用例子:
 
 */


@end
