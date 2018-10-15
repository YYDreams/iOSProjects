//
//  HHMultithreadingController.m
//  iOSProjects
//
//  Created by flowerflower on 2018/9/11.
//  Copyright © 2018年 flowerflower. All rights reserved.
//

#import "HHMultithreadingController.h"

@interface HHMultithreadingController ()

@property(nonatomic,assign)NSInteger ticketSurplusCount;

@property(nonatomic,strong)NSLock *lock; //处理线程安全

@property(nonatomic, strong)UIImageView *imgView;

@end

@implementation HHMultithreadingController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self threaddDemo];
    
    [self operationDemo];
    
    [self gcdDemo];
    
    

}


#pragma mark - NSThread
- (void)threaddDemo{
    
    
}

#pragma mark - NSOPeration
- (void)operationDemo{
    
    
    
}


#pragma mark - GCD
- (void)gcdDemo{
    
    [self gcddemo1];
    [self gcddemo2];
    [self gcddemo3];
    [self gcddemo4];
    [self gcddemo5];
    [self gcddemo6];
    [self gcddemo7];
    
}


- (void)gcddemo1{
    
    

    
    /**
     DISPATCH_QUEUE_CONCURRENT:并发 0表示并发
     DISPATCH_QUEUE_SERIAL:串行
     */
    
    //创建并发队列(注定队列名字+队列类型)
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"-------%@",[NSThread currentThread]);

    dispatch_async(queue, ^{

        NSLog(@"任务1----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务2----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务3----%@",[NSThread currentThread]);
    });
    
    
}

- (void)gcddemo2{
    
    
    //创建并发队列(注定队列名字+队列类型)
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"-------%@",[NSThread currentThread]);
    
    dispatch_async(queue, ^{
        
        NSLog(@"任务1----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务2----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务3----%@",[NSThread currentThread]);
    });
    
}

- (void)gcddemo3{
    
    //获取全局队列
    dispatch_queue_t queue =  dispatch_get_global_queue(0, 0);
        NSLog(@"---satrt----");
        dispatch_async(queue, ^{
            NSLog(@"任务1----%@",[NSThread currentThread]);
        });
        dispatch_async(queue, ^{
            NSLog(@"任务2----%@",[NSThread currentThread]);
        });
        dispatch_async(queue, ^{
            NSLog(@"任务3----%@",[NSThread currentThread]);
        });
        NSLog(@"---end---");
 
    
}
- (void)gcddemo4{
    
    //特殊串行队列/主队列
    //获取主队列
    dispatch_queue_t queue =  dispatch_get_main_queue();
    NSLog(@"---satrt------%@",[NSThread currentThread]);
    dispatch_async(queue, ^{
        NSLog(@"任务1----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务2----%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务3----%@",[NSThread currentThread]);
    });
    NSLog(@"---end---");
    
    
}

- (void)gcddemo5{
    
    dispatch_queue_t queue  = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"---satrt------%@",[NSThread currentThread]);
    dispatch_sync(queue, ^{
        NSLog(@"任务1----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务2----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务3----%@",[NSThread currentThread]);
    });
    NSLog(@"end---");
}

- (void)gcddemo6{
    
    dispatch_queue_t queue  = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    NSLog(@"---satrt------%@",[NSThread currentThread]);
    dispatch_sync(queue, ^{
        NSLog(@"任务1----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务2----%@",[NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"任务3----%@",[NSThread currentThread]);
    });
    NSLog(@"end---");
}
- (void)gcddemo7{

    NSLog(@"start----");
    //同步执行:立刻马上执行,如果我没有执行完毕,那么后面的也别想执行
    //异步执行:如果我没有执行完毕,那么后面的也可以执行
    //奔了: Thread 1: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0)
    dispatch_sync( dispatch_get_main_queue(), ^{
        NSLog(@"任务1----%@",[NSThread currentThread]);
    });
    NSLog(@"end---");
}
/**
 
 线程：指独立执行的代码段
 进程: 指一个正在运行的可执行程序，它可以包含多个线程
 任务: 指抽象的概念，表示需要执行工作
 
 1.基础简介
 NSThread
 
 NSOperation
 
 GCD
 
 
 2.结合案例使用
 例子1: 子线程下载图片 -> 主线程显示图片   --->NSThread 完成
 例子2: 售票的小故事
 引出问题:多个线程访问同一块资源会发生什么
 解决方式:资源抢夺的几种解决方式

 
 //多线程总结:
 
 GCD中的一些问题
 实际问题：
 1> 子线程同时执行ABC三个同步任务、全部执行完成再在子线程执行三个同步任务DEF。
 4> GCD的并行队列一定会开辟新的线程？
 5> 并行和并发的区别？
 6> 串行/并行、同步异步的区别?(附带如何判断GCD的执行顺序、是否开辟线程)
 
 
 
 NSOperation中的问题
 2> NSOperation可以像GCD一样设置串行并行么？
 3> NSBlockOperation和NSInvocationOperation有什么关系和区别
 
 
 NSOperation和GCD之间的区别
 7> NSOperation与GCD的关系
 9> NSOperation可以像GCD一样设置串行并行么？
 10> NSOperation设置优先级是否可以直接决定操作的执行顺序?
 
 1.资源抢夺的几种解决方式
 
 */



// 例子1: 子线程下载图片 -> 主线程显示图片
- (void)threadDemo1{
   
    [NSThread detachNewThreadSelector:@selector(loadImageFormNetwork) toTarget:self withObject:nil];
    
}
- (void)loadImageFormNetwork{
    
    NSLog("%@---",[NSThread currentThread]);
    NSURL *url = [NSURL URLWithString:@"http://upload-images.jianshu.io/upload_images/1658521-929b88123cf7156c.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    [self performSelectorOnMainThread:@selector(updateImage:) withObject:image waitUntilDone:YES];
    
}
- (void)updateImage:(UIImage *)image{
    
    
    NSLog("----%@---",[NSThread currentThread]);
    
    self.imgView.image = image;
    
    
    
}


/**
 
 
 GCD中的一些问题
 实际问题：
 1> 子线程同时执行ABC三个同步任务、全部执行完成再在子线程执行三个同步任务DEF。
 4> GCD的并行队列一定会开辟新的线程？
 5> 并行和并发的区别？
 6> 串行/并行、同步异步的区别?(附带如何判断GCD的执行顺序、是否开辟线程)

 
 
 NSOperation中的问题
 2> NSOperation可以像GCD一样设置串行并行么？
 3> NSBlockOperation和NSInvocationOperation有什么关系和区别

 
 NSOperation和GCD之间的区别
 7> NSOperation与GCD的关系
 9> NSOperation可以像GCD一样设置串行并行么？
10> NSOperation设置优先级是否可以直接决定操作的执行顺序?


 */


//问题一 子线程同时执行ABC三个同步任务、全部执行完成再在子线程执行三个同步任务DEF。
- (void)gcddemo8{
    /**
     1.创建并发队列(指定定队列名字+队列类型)
       队列类型:
       DISPATCH_QUEUE_CONCURRENT(并发队列): 不等待现在执行中的处理是否结束，继续执行下面的处理。只有在异步执行中，才能体现并发性
       DISPATCH_QUEUE_SERIAL（串行队列): 等待正在执行中的处理结束，再执行下一条处理。
     */
    //
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    
    //2.任务(同步、异步)
    /**
     执行任务的方式:
     同步 ->  不开启新的线程    dispatch_sync(queue, ^{  ...  });
     异步 ->  开启新的线程     dispatch_async(queue, ^{ ... });
     */
    
    dispatch_async(queue, ^{
       
        NSLog(@"同步执行->执行任务A---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        
        NSLog(@"同步执行->执行任务B---%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        
        NSLog(@"同步执行->执行任务C---%@",[NSThread currentThread]);
    });
    
    // dispatch_barrier_sync: 在它前面的任务执行结束后它才执行，在它后面的任务等它执行完成后才会执行
    dispatch_barrier_async(queue, ^{
       
        for (int i = 0; i< 1000; i++) {
            
            if (i == 999) {
            NSLog(@"----在barrier中添加耗时操作-----%@", [NSThread currentThread]);
            }
        }

        NSLog(@"ABC 全部执行完成之后再在子线程执行三个同步任务DEF");
    });
    
    
    dispatch_async(queue, ^{
    
        NSLog(@"同步执行->执行任务D---%@",[NSThread currentThread]);

    });
    
    
    dispatch_async(queue, ^{
        
        NSLog(@"同步执行->执行任务E---%@",[NSThread currentThread]);

    });
    
    dispatch_async(queue, ^{
        
        NSLog(@"同步执行->执行任务F---%@",[NSThread currentThread]);

    });

}


//NSOperation
/**
 
 为什么要使用 NSOperation、NSOperationQueue？
 可添加完成的代码块，在操作完成后执行。
 添加操作之间的依赖关系，方便的控制执行顺序。
 设定操作执行的优先级。
 可以很方便的取消一个操作的执行。
 使用 KVO 观察对操作执行状态的更改：isExecuteing、isFinished、isCancelled。

 */

/**
 使用步骤:
 1.创建操作:先将需要执行的操作封装到一个NSOperation对象中
 2.创建队列:创建NSOperationQueue对象
 3.将操作加入队列中: 将NSOperation对象添加到NSOperationQueue对象中
 
 综上之后 ->系统就会自动将NSOperationQueue中的NSOperation取出来,在新线程中执行操作
 
 
 */
- (void)test2{ 
    
    
    
    
//
//    [self userInvocationOperation];
//
//    [NSThread sleepForTimeInterval:2];
//
//
//    [self userThread];
//
//
//    //
//    [self userBlockOperationAddExecutionBolck];
//
//
//    //添加依赖 控制执行顺序
    [self addDependency];
    
    
    //异步请求耗时操作  主线程干正事
//    [self consumingOperation];
    
    
    //售票案例
//    [self buyTicketSafe];
    
    //
    
    
}
//NSInvocationOperation: 操作是在当前线程执行的，并没有开启新线程。
- (void)userInvocationOperation{
    
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(texttest) object:nil];
    
    //调用 start 方法开始执行操作
    [operation start];
    
}

//NSBlockOperation:操作是在当前线程执行的，并没有开启新线程
- (void)userBolockOperation{
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"userBolockOperation ---%@",[NSThread currentThread]);
    }];
    [operation start];
    
    
}


/**
 注意：和上边NSInvocationOperation使用一样。
 因为代码是在主线程中调用的,所以打印结果为主线程。
 如果在其他线程中执行操作,则打印结果为其他线程
 */
- (void)userBlockOperationAddExecutionBolck{
    
    /**
     如果一个 NSBlockOperation 对象封装了多个操作。NSBlockOperation 是否开启新线程，取决于操作的个数。
     如果添加的操作的个数多，就会自动开启新线程。当然开启的线程数是由系统来决定的。
     
     */
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
       
        NSLog(@"1 -- %@",[NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"2 -- %@",[NSThread currentThread]);

    }];
    [op addExecutionBlock:^{
        NSLog(@"3 -- %@",[NSThread currentThread]);
        
    }];

    [op addExecutionBlock:^{
        NSLog(@"4 -- %@",[NSThread currentThread]);
        
    }];

    [op addExecutionBlock:^{
        NSLog(@"5 -- %@",[NSThread currentThread]);
        
    }];
    [op addExecutionBlock:^{
        NSLog(@"6 -- %@",[NSThread currentThread]);
        
    }];
    [op addExecutionBlock:^{
        NSLog(@"7 -- %@",[NSThread currentThread]);
        
    }];
    
    [op addExecutionBlock:^{
        NSLog(@"8 -- %@",[NSThread currentThread]);
        
    }];
    
    [op addExecutionBlock:^{
        NSLog(@"9 -- %@",[NSThread currentThread]);
        
    }];

    [op start];
    
    
}


/**
 需求: 有 A、B 两个操作，其中 A 执行完操作，B 才能执行操作。
 */


//操作依赖
- (void)addDependency{
    
    //1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    //2.创建操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
       
        for (int i = 0; i < 1000; i++) {
            
            if (i == 999) {
                NSLog(@"----模拟添加耗时操作1111----");
            }
        }
        
        NSLog(@"执行任务A----%@",[NSThread currentThread]);

    }];

    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{

        for (int i = 0; i < 10; i++) {
            if (i == 9) {
                NSLog(@"----模拟添加耗时操作2222----");

            }
        }
        
        NSLog(@"执行任务B----%@",[NSThread currentThread]);

    }];
    //3.添加依赖
    [op2 addDependency:op1]; // 让op2 依赖于 op1，则先执行op1，在执行op2
    //4.添加操作到队列中
    [queue addOperation:op1];
    [queue addOperation:op2];
    
    
}



//NSOperation 需要配合 NSOperationQueue 来实现多线程。

/**
 在其他线程中执行耗时操作，等操作执行完了之后再回到主线程执行主线程的相应操作。
 
 */

- (void)demo1{
    
    
    //1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];

    //2.添加操作
    [queue addOperationWithBlock:^{
       
        NSURL *url = [NSURL URLWithString:@"http://upload-images.jianshu.io/upload_images/1658521-929b88123cf7156c.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
        UIImage *image  = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
          
            self.imgView.image = image;
        }];
    }];
    
    
}
- (void)consumingOperation{
    
    //1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    //2.添加操作
    [queue addOperationWithBlock:^{
       //耗时操作
        for (int i = 0; i < 1000 ; i++) {
            
            NSLog(@"%@ ---耗时操作-NSOperation----",[NSThread currentThread]);
            
        };
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
           
            
            NSLog(@"回归主线程 %@",[NSThread currentThread]);
        }];
        
        
    }];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self buyTicket];
}
- (void)buyTicket{

    self.ticketSurplusCount = 30;
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    /**
    信号量：就是一种可用来控制访问资源的数量的标识，设定了一个信号量，在线程访问之前，加上信号量的处理，则可告知系统按照我们指定的信号量数量来执行多个线程。
     其实，这有点类似锁机制了，只不过信号量都是系统帮助我们处理了，我们只需要在执行线程之前，设定一个信号量值，并且在使用时，加上信号量处理方法就行了。
     
     dispatch_semaphore_create(信号量值)      创建信号量, 参数：信号量的初值，如果小于0则会返回NULL
     dispatch_semaphore_wait（信号量，等待时间） 等待降低信号量
     dispatch_semaphore_signal(信号量)         提高信号量
     注意:正常的使用顺序是先降低然后再提高，这两个函数通常成对使用
     */

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    
    
    while (1) {
        dispatch_async(queue, ^{
            
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

            if (self.ticketSurplusCount > 0 ) {
                
                  self.ticketSurplusCount --;
                NSLog(@"剩余票数:%zd 窗口:%@",self.ticketSurplusCount,[NSThread currentThread]);
            
            }
            dispatch_semaphore_signal(semaphore);

            
        });
        
        NSLog("%@---############---",[NSThread currentThread]);
            if (self.ticketSurplusCount <= 0) {
                
                  NSLog(@"不好意思。。票买完了。。。。");
                break;
            }
    }

    
    
    

}
    
    




/***
 
 线程安全解决方案：可以给线程加锁，在一个线程执行该操作的时候，不允许其他线程进行操作。
 iOS 实现线程加锁有很多种方式。@synchronized、 NSLock、NSRecursiveLock、NSCondition、NSConditionLock、pthread_mutex、dispatch_semaphore、OSSpinLock、atomic(property) set/ge等等各种方式。
 这里我们使用 NSLock 对象来解决线程同步问题。NSLock 对象可以通过进入锁时调用 lock 方法，解锁时调用 unlock 方法来保证线程安全。
 

 */

//售票的小故事
- (void)buyTicketSafe{
    
    _ticketSurplusCount = 30;

    self.lock = [[NSLock alloc]init];
    
    NSOperationQueue *queue1 = [[NSOperationQueue alloc]init];
    queue1.maxConcurrentOperationCount = 1;
    
    NSOperationQueue *queue2 = [[NSOperationQueue alloc]init];
    queue2.maxConcurrentOperationCount = 1;
    
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [self saleTicketSafa];
    }];
    
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        
        [self saleTicketSafa];
    }];
    
    //添加操作
    [queue1 addOperation:op1];
    [queue2 addOperation:op2];
    
}

- (void)saleTicketSafa{
    
    
    while (1) {
        
        //加锁
        [self.lock lock];
        
        
        if (self.ticketSurplusCount > 0) {
            
            
            self.ticketSurplusCount --;
            
            NSLog(@"剩余票数:%zd 窗口:%@",self.ticketSurplusCount,[NSThread currentThread]);
        }
        
        //解锁
        [self.lock unlock];
        
        if (self.ticketSurplusCount  <=0) {
            NSLog(@"不好意思。。票买完了。。。。");
            break;        }
    }
    
}



//NSThread
- (void)userThread{
    //// 在其他线程使用子类 NSInvocationOperation
    [NSThread detachNewThreadSelector:@selector(userInvocationOperation) toTarget:self withObject:nil];
    
}
- (void)texttest{
    
    NSLog(@"userInvocationOperation ---%@",[NSThread currentThread]);
    
    
}

- (UIImageView *)imgView{
    
    if (!_imgView) {
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake((Screen_Width - 200)/2, (Screen_Height - 200)/2, 200, 200)];
        [self.view addSubview:_imgView];
    }
    return _imgView;
    
}




@end
