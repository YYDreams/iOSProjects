//
//  SqliteTool.m
//  数据存储
//
//  Created by 花花 on 2017/9/13.
//  Copyright © 2017年 花花. All rights reserved.
//

#import "SqliteTool.h"

#import <sqlite3.h>

@implementation SqliteTool
static sqlite3 *_db;


+ (void)initialize{
    //1,创建数据库
    //打开一个指定的数据库，如果数据库不存在 就创建 存在就直接打开，并且赋值给参数2
    
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
//    NSString *filePath = [path stringByAppendingPathComponent:@"userInfo.sqlite"];
    // 参数1：s数据库的路径
    
//    NSLog(@"%@",filePath);
    //参数2 ：一个已经打开的数据库（如果后期要执行sql语句，都需要借助这个对象）
    // sqlite3 *db; // 一个db就代表一个数据库
    //UserDataFilePath ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"user.plist"])
    int result =  sqlite3_open(UserDataFilePath.UTF8String, &_db);
    
    if (SQLITE_OK == result) {
        
        NSLog(@"数据库打开成功");
        //2. 创建表
        const char *sql = "CREATE TABLE IF NOT EXISTS t_userInfo (id INTEGER PRIMARY KEY AUTOINCREMENT, account TEXT NOT NULL, nickname  TEXT NOT NULL);";
        
        char *error;
        /*
         第1参数:需要执行sql语句的数据库
         第2参数:需要执行的sql语句
         第3参数:执行完sql语句之后的回调方法
         第4参数:回调方法的参数
         第5参数:错误信息
         */
        sqlite3_exec(_db, sql, NULL, NULL, &error);
        if (error == nil) {
            NSLog(@"创建表成功");
        }else{
            NSLog(@"创建表失败");
            
        }
    }else{
        
        NSLog(@"数据库打开失败");
        
    }
}
+ (BOOL)saveUserInfo:(UserModel *)userInfo{
    
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_userInfo(account,nickname) VALUES ('%@','%@');",userInfo.account,userInfo.nickname];
    char *error;
    sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &error);
    
    //(char *) error = 0x0000604000016a50 "disk I/O error"

    if (error) {//插入失败
        return NO;
    }else{//插入成功
        return YES;
    }
}



+ (NSArray *)userInfo{
    
    NSMutableArray *models = nil;
    
    char *sql  = "SELECT id, account, nickname FROM t_userInfo;";
    // 1.准备查询
    sqlite3_stmt *stmt; // 用于提取数据的变量

    
    int result = sqlite3_prepare_v2(_db, sql, -1, &stmt, NULL);
    if (SQLITE_OK == result) {
        models = [NSMutableArray array];
        // 准备好了
        while (SQLITE_ROW == sqlite3_step(stmt)) {  // 提取到一条数据
            // 从stmt中取出提取到的数据
            int ID = sqlite3_column_int(stmt, 0);
            const unsigned char * account = sqlite3_column_text(stmt, 1);
            const unsigned char * nickname = sqlite3_column_text(stmt, 2);
//            double age = sqlite3_column_double(stmt, 2);
            // 创建模型
            UserModel * info = [[UserModel alloc]init];
            info.ID = [NSString stringWithFormat:@"%d",ID];
            
            info.account = [NSString stringWithCString:(const char *)account encoding:NSUTF8StringEncoding];
            info.nickname =[NSString stringWithCString:(const char *)nickname encoding:NSUTF8StringEncoding];
            [models addObject:info];
            
        }
    }
    
    
    return models;
    
}


+ (void)clearInfo{
    
    
    NSString *deleteSql = @"delete from t_userInfo where id = 1";
    char *error;
    if (sqlite3_exec(_db, [deleteSql UTF8String], NULL, NULL,  &error) == SQLITE_OK) {
        
        NSLog(@"删除成功");
        
    }else{
        NSLog(@"删除失败");
    }
    
    
    
    
    
    
}



@end
