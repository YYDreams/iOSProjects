//
//  HHDataStoreController.m
//  iOSProjects
//
//  Created by flowerflower on 2018/9/11.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHDataStoreController.h"
#import "SqliteTool.h"
@interface HHDataStoreController ()
@property (weak, nonatomic) IBOutlet UILabel *saveLabel;

@property (weak, nonatomic) IBOutlet UILabel *readLabel;
@end

@implementation HHDataStoreController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - setupNav
#pragma mark - setupTableView

#pragma mark - loadDataFromNetwork

#pragma mark - <UITableViewDataSource,UITableViewDelegate>

#pragma mark - SEL Method
#pragma mark - 属性列表（plist）
/**
 如何判断一个对象能不能使用plist,就看下有没有writeToFile
 plist使用注意：不能存储自定义对象 可存储字典或者数组
 */
- (IBAction)plistSaveOnClick {
    
    //    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //    [dic setObject:@"小明" forKey:@"name"];
    //    //将字典持久化到Documents/
    //    [dic writeToFile:path atomically:YES];
    NSArray *arr = @[@"123",@"咋啦"];
    /**
     1、获取应用的文件夹（应用沙盒）
     NSSearchPathDirectory 搜索的目录
     NSSearchPathDomainMask 搜索范围 NSUserDomainMask：表示在用户的手机上查找
     expandTilde 是否展开全路径~ 如果没有展开,应用的沙盒路径就是~
     存储一定要展开路径 如果要存东西 必须要是YES
     */
    //YES:///Users/huahua/Library/Developer/CoreSimulator/Devices/0FB528AF-C34D-4F64-A723-6129E3FF3964/data/Containers/Data/Application/6FEDA2B8-40C2-40EA-9685-FE6DC828D7D2/Library/Caches
    //NO: ~/Library/Caches
    
    self.saveLabel.text = [NSString stringWithFormat:@"%@",arr];
    
    [arr writeToFile:UserDataFilePath atomically:YES]; //    file：文件的全路径
    
}
- (IBAction)plistReadOnClick {
    
    NSArray *arr =  [NSArray arrayWithContentsOfFile:UserDataFilePath];
    
    self.readLabel.text = [NSString stringWithFormat:@"%@ ",arr];
    NSLog(@"%@",arr);
    
}


#pragma mark - 偏好设置

/**
 偏好设置好处:
 1.不需要关心文件名（不需要设置路径）
 2.键值对存储（账号相关信息） 对象存储
 底层实现原理就是封装了一个字典
 
 */
- (IBAction)userDefaultsSaveOnClick {

    //存
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //放到缓存里，并不会马上放到文件里面
    [userDefaults setObject:@"123" forKey:@"account"]; //对象
    [userDefaults setObject:@"123456" forKey:@"pwd"];
    [userDefaults setInteger:2 forKey:@"Int"];
    [userDefaults setBool:YES forKey:@"status"];
    //在ios7 默认不会马上跟硬盘同步  同步操作 起到立即存储的作用
    [userDefaults synchronize];
    
    self.saveLabel.text = [NSString stringWithFormat:@"account:%@ pwd:%@ Int:%ld status:%d",
                           [[NSUserDefaults standardUserDefaults]objectForKey:@"account"],
                           [[NSUserDefaults standardUserDefaults]objectForKey:@"pwd"],
                           [[NSUserDefaults standardUserDefaults] integerForKey:@"Int"],
                           [[NSUserDefaults standardUserDefaults]  boolForKey:@"status"]
                           ];
}

- (IBAction)userDefaultsReadOnClick {

    
    NSString *account = [[NSUserDefaults standardUserDefaults]objectForKey:@"account"];
    NSString *pwd = [[NSUserDefaults standardUserDefaults]objectForKey:@"pwd"];
    NSInteger int2 = [[NSUserDefaults standardUserDefaults] integerForKey:@"Int"];
    BOOL status = [[NSUserDefaults standardUserDefaults]  boolForKey:@"status"];
    self.readLabel.text = [NSString stringWithFormat:@"account:%@ pwd:%@ Int:%ld status:%d",account,pwd,int2,status];
}

#pragma mark - NSKeyedArchiver(归档)

//归档
/**
 自定义对象想要归档，则自定义对象必须遵守NSCoding协议，实现协议方法
 */
- (IBAction)keyedArchiverSaveOnClick {

    
    UserModel *userInfo = [[UserModel alloc]init];
    userInfo.account = @"18673556376";
    userInfo.nickname = @"abc";
    
    self.saveLabel.text = [NSString stringWithFormat:@"%@",userInfo];
    //获取cache
//    NSString *cachesPath =NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    ////获取文件的全路径
//    NSString *filePath =  [cachesPath stringByAppendingPathComponent:@"Uesr.data"];
    //系统会自动调用encodeWithCoder方法
    [NSKeyedArchiver archiveRootObject:userInfo toFile:UserDataFilePath];
    
    self.saveLabel.text = [NSString stringWithFormat:@"%@ %@",userInfo.account,userInfo.nickname];
}

- (IBAction)keyedArchiverReadOnClick {

    
    //获取cache
//    NSString *cachesPath =NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    ////获取文件的全路径
//    NSString *filePath =  [cachesPath stringByAppendingPathComponent:@"Uesr.data"];
    //解档 系统会自动调用initWithCoder方法
    UserModel *userInfo = [NSKeyedUnarchiver unarchiveObjectWithFile:UserDataFilePath];
    
    NSLog(@"NSKeyedArchiver归档-----账号:%@---昵称:%@",userInfo.account,userInfo.nickname);
    self.readLabel.text = [NSString stringWithFormat:@"%@ %@",userInfo.account,userInfo.nickname];
}
#pragma mark - sqlite3

- (IBAction)sqlite3SaveOnClick {

    
    UserModel *info = [[UserModel alloc]init];
    info.account = @"110";
    info.nickname = @"AAAA";
    
    BOOL success =  [SqliteTool saveUserInfo:info];
    
    if (success) {
        NSLog(@"插入成功");
        
        self.saveLabel.text = [NSString stringWithFormat:@"account:%@ 昵称:%@",info.account,info.nickname];
    }else{
        NSLog(@"插入失败");
    }
}
- (IBAction)sqlite3ReadOnClick {
    
    NSArray *arr = [SqliteTool  userInfo];
    
    for (UserModel *info in arr) {
        NSLog(@"%@ %@",info.account,info.nickname);
        self.readLabel.text = [NSString stringWithFormat:@"account:%@ 昵称:%@",info.account,info.nickname];
        
    }
}

#pragma mark - FMDB

- (IBAction)FMDBSaveOnClick {
    
}
- (IBAction)FMDBReadOnClick {
}


#pragma mark - CoreData

#pragma mark - 清空数据

- (IBAction)clearOnClick {
    

    
    [LoginHandle clearUserInfo];
    
    
    [SqliteTool clearInfo];
    
    
    //偏好设置 移除 数据
    [[NSUserDefaults standardUserDefaults]removeObjectForKey: @"account"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey: @"pwd"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey: @"Int"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey: @"status"];

}

#pragma mark - Custom Method

#pragma mark - Setter && Getter Methods




@end
