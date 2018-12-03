//
//  ViewController.m
//  1.多线程
//
//  Created by 李善武 on 2018/12/1.
//  Copyright © 2018年 李善武. All rights reserved.
//

#import "ViewController.h"
// 多线程分为1.GCD 和 2.NSOPeration两个部分来掌握
@interface ViewController (){
    dispatch_semaphore_t semaphoreLock;
}

@property (nonatomic,assign)int ticketCount;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 1.串行队列、并行队列、主队列、同步执行、异步执行组合
//    [self gcdTest];
    
    // 2.线程间通信
//    [self communicateInThread];
    
    // 3.栅栏函数
//    [self barrierMethod];
    // 4.队列组
//    [self queueGroup];
    // 5.信号量
    [self gcd_semaphore];
}
/*
 * 1.是什么：
 *    苹果开发的利用多核编程的技术，是一套C语言的API接口。
 *   核心概念：队列和任务
 * 2.优点：
 *    a.可以充分利用cpu多核的特性
 *    b.可以自动管理线程的生命周期
 * 3.主要的技术：
 *    a.多线程同步异步以及串行并发的实现
 *    b.一次性函数
 *    c.延时函数
 *    d.快速迭代
 * 4.GCD线程间的通信：
 *    我们一般把UI事件放到主线程中执行，比如：拖拽、滚动等，而把耗时操作，
 *    例如：图片下载、文件上传放到子线程中，而当耗时操作执行完后，要进入主
 *    线程进行相应操作，这就用到了线程间的通信
 *
 *
 *
 *
 *
 */
- (void)gcdTest{
    
    // 多线程实现：队列+执行方式，比如：主队列+同步执行
    
    // 1.串行队列+同步执行:不会开辟新线程，同步执行
//    dispatch_queue_t queue = dispatch_queue_create("synQueue", DISPATCH_QUEUE_SERIAL);
//    dispatch_sync(queue, ^{
//
//        // 追加任务1
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
//        }
//    });
//
//
//    dispatch_sync(queue, ^{
//
//        // 追加任务1
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
//        }
//    });
    
    
    // 2.串行队列+异步执行：开辟新的线程，同步执行
//    dispatch_queue_t queue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
//    dispatch_async(queue, ^{
//
//        // 追加任务1
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
//        }
//    });
//
//    dispatch_async(queue, ^{
//
//        // 追加任务2
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
//        }
//    });
    
    // 3.主队列+同步执行：
//       主线程中调用：互相等待造成死锁，crash掉
//       子线程中调用：不会开辟新线程，同步执行
//    dispatch_queue_t queue = dispatch_get_main_queue();
//    dispatch_sync(queue, ^{
//
//        // 追加任务2
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
//        }
//    });
//
//    dispatch_sync(queue, ^{
//
//        // 追加任务2
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
//        }
//    });
    
    // 主队列+异步执行:不会开辟新的线程，同步执行
//    dispatch_queue_t queue = dispatch_get_main_queue();
//    dispatch_async(queue, ^{
//
//        // 追加任务2
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
//        }
//    });
//
//    dispatch_async(queue, ^{
//
//        // 追加任务2
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
//        }
//    });
    // 并发队列+同步执行：不开辟新的线程，同步执行
//    dispatch_queue_t queue = dispatch_queue_create("currentQueue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_sync(queue, ^{
//
//        // 追加任务2
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
//        }
//    });
//
//    dispatch_sync(queue, ^{
//
//        // 追加任务2
//        for (int i = 0; i < 2; ++i) {
//            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
//            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
//        }
//    });
    
    // 并发队列+异步执行：开辟新的线程，异步执行
    dispatch_queue_t queue = dispatch_queue_create("currentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{

        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });

    dispatch_async(queue, ^{

        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
}

// 2.模拟线程间通信
- (void)communicateInThread{
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(globalQueue, ^{
        
        // 追加任务2
        for (int i = 0; i < 5; ++i) {
            [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
        
        dispatch_async(queue, ^{
           
            NSLog(@"耗时操作完成:%@----%@",[NSThread currentThread].name,[NSThread currentThread]);
        });
    });
    
}

// 3.栅栏函数:
- (void)barrierMethod{
    
    dispatch_queue_t queue = dispatch_queue_create("currentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    dispatch_async(queue, ^{
        
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
//    dispatch_barrier_async和dispatch_barrier_sync：后面任务插入的时间不同
    dispatch_barrier_sync(queue, ^{
        
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
            NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_async(queue, ^{
        
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
            NSLog(@"4---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_async(queue, ^{
        
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
            NSLog(@"5---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
}

// 4.延时操作
- (void)delayAfter{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 2.0秒后异步追加任务代码到主队列，并开始执行
        NSLog(@"after---%@",[NSThread currentThread]);  // 打印当前线程
    });
}

// 5.一次性函数
- (void)onceToken{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 只执行1次的代码(这里面默认是线程安全的)
    });
}

// 6.遍历函数,在串行执行的条件下等同于for循环，并发队列异步执行时相较于for循环优势明显
- (void)apply{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSLog(@"apply---begin");
    dispatch_apply(6, queue, ^(size_t index) {
        NSLog(@"%zd---%@",index, [NSThread currentThread]);
    });
}

// 7.队列组
- (void)queueGroup{
    
    // dispatch_group_notify:监听group中任务的完成状态，当任务都完成时，追加任务到group中
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
            NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:1];              // 模拟耗时操作
            NSLog(@"4---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    // 阻塞当前线程，队列组中的任务全部执行完成才会向下执行
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"队列组中的任务已经执行完成");
}

// 信号：dispatch_semaphore
- (void)gcd_semaphore{
    
    // 1.将异步执行的任务转换为同步执行
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
//    __block int number = 0;
//    dispatch_async(queue, ^{
//
//        // 追加任务1
//        [NSThread sleepForTimeInterval:2.0];
//        NSLog(@"1------%@",[NSThread currentThread]);
//        number = 100;
//        dispatch_semaphore_signal(semaphore);
//    });
//    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//    NSLog(@"semaphore---end,number = %d",number);
    
    
    // 2.线程安全
    [self salesManSellTicket];
}

// 售票员卖票
- (void)salesManSellTicket{
    
    self.ticketCount = 50;
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue1 = dispatch_queue_create("serialQueue1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2= dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    
    semaphoreLock = dispatch_semaphore_create(1);
    // 线程安全问题一定是两个线程并发访问的问题
    dispatch_async(queue1, ^{
        
//        // 安全售票
//        [weakSelf sellTicketSecurity];
        // 不安全售票
        [weakSelf sellTicketUnSecurity];
    });
    dispatch_async(queue2, ^{
        
//        // 安全售票
//        [weakSelf sellTicketSecurity];
        // 不安全售票
        [weakSelf sellTicketUnSecurity];
    });
}
- (void)sellTicketSecurity{
    
    while (1) {
        
        // 加锁
        dispatch_semaphore_wait(semaphoreLock, DISPATCH_TIME_FOREVER);
        if (self.ticketCount>0) {
            self.ticketCount--;
            NSLog(@"还剩的电影票---%d张",self.ticketCount);
            [NSThread sleepForTimeInterval:0.2];
        }else{
            
            NSLog(@"电影票已经售完");
            // 解锁
            dispatch_semaphore_signal(semaphoreLock);
            break;
        }
        // 解锁
        dispatch_semaphore_signal(semaphoreLock);
    }
}
- (void)sellTicketUnSecurity{
    
    while (1) {
        
        if (self.ticketCount>0) {
            
            self.ticketCount--;
            NSLog(@"还剩的电影票---%d张",self.ticketCount);
            [NSThread sleepForTimeInterval:0.2];
        }else{
        
            dispatch_semaphore_signal(semaphoreLock);
            break;
        }
    }
}
@end
