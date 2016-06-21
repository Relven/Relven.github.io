---
title: NSOperation和GCD，带点NSThread
date: 2015-2-13 21:14:54
tags:
  - 多线程
categories: 使用
---


程序是指令和数据的有序集合，其本身没有任何运行的含义，是一个静态的概念。而进程是程序在处理机上的一次执行过程，它是一个动态的概念。

程作为分配资源的基本单位，而把线程作为独立运行和独立调度的基本单位

首先iOS三种多线程NSThread，NSOperation和GCD的抽象程度由低到高，GCD用起来最方便。

### NSThread
#### 显示调用NSThread类
`类方法`

	[NSThread detachNewThreadSelector:@selector(doSomething:) toTarget:self withObject:@"hi"];
	
`实例方法`

	SThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(doSomething:) object:@"hi"];	[thread start]; 
#### 隐式调用
`开启后台线程`

	[self performSelectorInBackground:@selector(doSomething:) withObject:@"hi"];
`在主线程中运行`

	[self performSelectorOnMainThread:@selector(doSomething:) withObject:@"hi" waitUntilDone:YES];
	
`在指定线程中运行，但该线程必须具备run loop`

	   [self performSelector::@selector(doSomething:) onThread:thread withObject:@"hi" waitUntilDone:YES];
//waitUntilDone:YES   同步等待

#### 常见NSThread的方法```+ (NSThread *)currentThread; //获得当前线程
+ (void)sleepForTimeInterval:(NSTimeInterval)ti; //线程休眠   
+ (NSThread *)mainThread; //  主线程，即UI线程
- (BOOL)isMainThread;+ (BOOL)isMainThread; // 当前线程是否主线程- (BOOL)isExecuting; //线程是否正在运行- (BOOL)isFinished; //线程是否已结束```  


### NSOperation

`NSInvocationOperation`

//创建一个队列

	NSOperationQueue queue = [[NSOperationQueue alloc]init];
//创建子任务，定义子任务必须是NSOperation的子类

	 NSInvocationOperation operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(doSomething:) object:@"hi"];	
//当把任务添加到队列后，自动开启线程

	 [queue addOperation:operation];
	 
`NSBlockOperation`

//创建一个队列

	NSOperationQueue queue = [[NSOperationQueue alloc]init];
	
//创建NSBlockOperation对象

	NSBlockOperation operation = [NSBlockOperation blockOperationWithBlock:^{
	[self doSomething];
	}];
//加入队列

	[queue addOperation:operation];
	
	
	
### GCD
GCD中的FIFO队列称为dispatch_queue,它可以保证先进来的任务先得到执行
dispatch_queue分为以下三种：

##### Serial

又称为private_dispatch_queues，串行队列。Serial——queue通常用于同步访问特定的资源或数据。

##### Concurrent
又称为global_diapatch_queue，并发队列，但是执行完成的顺序是随机的。

##### Main_dispatch_queue
它是全局可用的serial_queue，它是在应用程序主线程上执行任务的。

#### 常用方法

##### dispatch_queue_t 队列类型
`Serial	`
	
	dispatch_queue_t  dispatch_queue_create( const char *label ，dispatch_queue_attr_t attr);

//例子

	dispatch_queue_t myQueue ＝ dispatch_queue_create("com.powernode.iOS",NULL);
	//其中，第一个参数是标识队列的，第二个参数是用来定义队列的参数（串行或者并发，NULL为串行）。

`Concurrent	`
	
	dispatch_queue_t dispatch_get_global_queue(   long priority,  unsigned long flags); 	//第一个参数：用于指定优先级
	
	#define DISPATCH_QUEUE_PRIORITY_HIGH 	#define DISPATCH_QUEUE_PRIORITY_DEFAULT 	#define DISPATCH_QUEUE_PRIORITY_LOW   	#define DISPATCH_QUEUE_PRIORITY_BACKGROUND  	第二个参数：目前未使用并且应该始终为0
	
`Main dispatch queue`
	
	dispatch_queue_t dispatch_get_main_queue(void);
	
##### 异步派发操作示例

	void dispatch_async(dispatch_queue_t queue, dispatch_block_t block);
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{   // 耗时的操作     dispatch_async(dispatch_get_main_queue(), ^{        // 更新界面     }); });
	
	
##### 	组策略
	dispatch_group_t   dispatch_group_create( void );	
	void dispatch_group_async(  dispatch_group_t group,   dispatch_queue_t queue,   dispatch_block_t block);
	
	void dispatch_group_notify( dispatch_group_t group,  dispatch_queue_t queue, dispatch_block_t block);







