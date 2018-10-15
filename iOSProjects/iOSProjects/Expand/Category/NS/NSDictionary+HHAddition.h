//
//  NSDictionary+HHAddition.h
//  HHToolCategory
//
//  Created by Mac on 2018/8/6.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (HHAddition)

- (NSString*) jsonEncodedKeyValueString;

+ (id)changeType:(id)myObj;
@end
