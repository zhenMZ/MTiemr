# MTiemr

####代码很简单，只是为了实现cell上定时器，内容可随意改动,一个页面只用到一个定时器

![GitHub set up](https://github.com/zhenMZ/MTiemr/blob/master/TimeDown/TimeDown/imgs/listen.gif?raw=true)


##使用方法
```
   1.导入MZTimeManager文件夹到项目中
   2.在需要使用的页面导入‘ #import "MZCountDownManager.h" ’
   3.添加代码，启动定时器
	 MZCountDownManager* manger = [[MZCountDownManager alloc] initWithManagerNotification:@"TwoViewControllerNotification"];
     [manger start];
    
   4. 考虑到可能存在多个倒计时的情况，使用了通知一对多传值
   		 接受通知
   		 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification:) name:@"TwoViewControllerNotification" object:nil];
   		 
   		实现方法
   		 - (void)countDownNotification:(NSNotification*)noti {
   		 	nslog(@"%@",noti.object);
   		 	 }
   5. 释放定时器
   - (void)dealloc {
   		  [_manger invalidate];
   	 	  NSLog(@"释放定时器");
	}
```

代码非常简单，MZCountDownManager.m实现文件100行左右，所有人都看得懂，改动起来特别方便，具体请看demo



