//
//  Test1ViewController.m
//  iOSProjects
//
//  Created by flowerflower on 2018/8/20.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "Test1ViewController.h"

@interface Test1ViewController ()

@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    
    NSLog(@"我没毒");
    [self test];

    self.view.backgroundColor = [UIColor hh_redomColor];
}



- (void)test{
    
//    1-2-3-null   -> 3-2-1-null
    

    
    //1.原始数组
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",nil];
    
    //        //exchangeObjectAtIndex:withObjectAtIndex:   (替换两个下标对应元素)
    //2.倒序的数组
    NSLog(@"=======%@",[[array reverseObjectEnumerator]allObjects ]);
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSLog(@" obj = %@ obj = %zd ",obj,idx);
        
    }];
  //
    
}

@end
