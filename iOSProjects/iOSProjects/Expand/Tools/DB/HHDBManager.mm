//
//  HHDBManager.m
//  iOSProjects
//
//  Created by flowerflower on 2018/11/19.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHDBManager.h"
#import <WCDB/WCDB.h>
@interface HHDBManager()

/**  */
@property (nonatomic, strong) WCTDatabase *database;

/** <#注释#> */
@property (nonatomic, strong) NSString *tableName;

/**  */
@property (nonatomic, strong) Class objectClass;
@end

@implementation HHDBManager
//static HHDBManager * instance = nil;

//+ (instancetype)shareInstance{
//
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        instance = [[self alloc]init];
//    });
//
//    return  instance;
//
//}

- (instancetype)initWithobjectClass:(Class)objectClass{

    
    if (self = [super init]) {
    
       self.tableName = NSStringFromClass(objectClass);
        self.objectClass = objectClass;

        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filePath = [documentsPath stringByAppendingPathComponent:@"flower.sqlite"];

        NSLog("filePath:%@",filePath);
        WCTDatabase *database = [[WCTDatabase alloc]initWithPath:filePath];
        self.database = database;
        if (![database isTableExists:self.tableName]) {
            [database createTableAndIndexesOfName:self.tableName withClass:objectClass];
        }
    }
    return self;
    
}


- (void)insertObjects:(NSArray *)objects{
    [self.database deleteAllObjectsFromTable:self.tableName];
    [self.database insertOrReplaceObjects:objects into:self.tableName];
}

- (NSArray *)getAllObjects{
    NSArray *list = [self.database getAllObjectsOfClass:self.objectClass fromTable:self.tableName];
    return list;
}

@end
