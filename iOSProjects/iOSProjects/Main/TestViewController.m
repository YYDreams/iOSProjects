//
//  TestViewController.m
//  iOSProjects
//
//  Created by flowerflower on 2018/8/20.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "TestViewController.h"
#import "HHWeChatFloatingBtn.h"
@interface TestViewController ()

@end

@implementation TestViewController

- (void)navRightOnClick{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"添加浮窗" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *defalutAction = [UIAlertAction actionWithTitle:@"添加浮窗" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action
                                                                                                                    ) {
        [HHWeChatFloatingBtn show];
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVc addAction:defalutAction];
    [alertVc addAction:cancelAction];
    
    [self presentViewController:alertVc animated:YES completion:nil];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"浮窗" style:0 target:self action:@selector(navRightOnClick)];
    
    
//    [MBProgressHUD LY_ShowSuccess:[NSString stringWithFormat:@"token:%@",LH.userInfo.token]];
//    NSLog(@"------%@",LH.userInfo.token);
//    
//    self.titles  = @[@"",@"",@"",@"",
//                     @"",@"",@"",@"",
//                     @"",@"",@"",@"",
//                     @"",@"",@"",@"",
//                     @"",@"",@"",@"",
//                     @"",@"",@"",@"",
//                     @"",@"",@"",@"",
//                     @"",@"",@"",@"",
//                     @"",@"",@"",@""];
//    
//    self.classNames = @[@"Test1ViewController",@"Test1ViewController",@"Test1ViewController",@"Test1ViewController",
//                        @"Test1ViewController",@"Test1ViewController",@"Test1ViewController",@"Test1ViewController",
//                        @"Test1ViewController",@"Test1ViewController",@"Test1ViewController",@"Test1ViewController",
//                        @"Test1ViewController",@"Test1ViewController",@"Test1ViewController",@"Test1ViewController",
//                        @"Test1ViewController",@"Test1ViewController",@"Test1ViewController",@"Test1ViewController",
//                        @"Test1ViewController",@"Test1ViewController",@"Test1ViewController",@"Test1ViewController",
//                        @"Test1ViewController",@"Test1ViewController",@"Test1ViewController",@"Test1ViewController",
//                        @"Test1ViewController",@"Test1ViewController",@"Test1ViewController",@"Test1ViewController",
//                        @"Test1ViewController",@"Test1ViewController",@"Test1ViewController",@"Test1ViewController"];
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//    [self test1];
//    [self test2];
//    [self test3];
    
}


- (void)test1{
    
    
    
    //1.创建队列组
    dispatch_group_t group = dispatch_group_create();
    //2.获取全局并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);

    //3.往队列中添加耗时操作
    dispatch_group_async(group, queue, ^{
       
        //执行耗时的异步操作1
        NSLog(@"/执行耗时的异步操作1");
    });
    
    dispatch_group_async(group, queue, ^{
       
        NSLog(@"/执行耗时的异步操作2");
    });
    
    //当并发队列组中的任务执行完毕才能执行这里
    dispatch_group_notify(group, queue, ^{
        
        //回归主线程
        dispatch_group_async(group, dispatch_get_main_queue(), ^{
           
            NSLog(@"跟新UI");
        });
    });
}

- (void)test2{
    
    
    dispatch_queue_t queue = dispatch_queue_create("12342234", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"----1-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----2-----%@", [NSThread currentThread]);
    });
    
    // 在它前面的任务执行结束后它才执行，在它后面的任务等它执行完成后才会执行
    dispatch_barrier_async(queue, ^{
        
        for (int i = 0; i< 100; i++) {
            if (i >90) {
                NSLog(@"%zd",i);
            }
            
        }
        NSLog(@"----barrier-----%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"----3-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----4-----%@", [NSThread currentThread]);
    });
    
}

- (void)test3{
    
//    //主线程死锁
//    NSLog(@"1");
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"2");
//    });
//
//    NSLog(@"3");
}

@end
