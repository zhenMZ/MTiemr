//
//  MZCountDownManager.m
//  TupoApp
//
//  Created by zhen mz on 2018/8/29.
//  Copyright © 2018年 mz. All rights reserved.
//

#import "MZCountDownManager.h"


@interface MZCountDownManager ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) NSString *notificationName;
/**
 后台模式使用，记录进入后台的绝对时间
 */
@property (nonatomic, assign) BOOL backgroundRecord;
@property (nonatomic, assign) CFAbsoluteTime lastTime;

@end

@implementation MZCountDownManager


- (instancetype)initWithManagerNotification:(NSString *)notificationName {
    self = [super init];
    if (self) {
        self.notificationName = notificationName;
        self.timeInterval = 0;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForegroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    return self;
}

/**
 开启倒计时
 */
- (void)start {
    [self timer];
}

- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (void)timerAction {
    [self timerActionWithTimeInterval:1];
}

- (void)timerActionWithTimeInterval:(NSInteger)timeInerval {
    self.timeInterval += timeInerval;
    if (!self.notificationName) {
        self.notificationName = MZCountDownDefaultNotification;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:self.notificationName object:@(self.timeInterval)];

}

/**
 停止倒计时
 */
- (void)invalidate {
    [self.timer invalidate];
    self.timer = nil;
}

/**
 刷新时间差
 */
- (void)reload {
    _timeInterval = 0;
}

/**
 进入后台
 */
- (void)applicationDidEnterBackgroundNotification {
    self.backgroundRecord = (_timer != nil);
    if (self.backgroundRecord) {
        self.lastTime = CFAbsoluteTimeGetCurrent();
        [self invalidate];
    }
}

/**
 进入前台
 */
- (void)applicationWillEnterForegroundNotification {
    if (self.backgroundRecord) {
        CFAbsoluteTime timeInterval = CFAbsoluteTimeGetCurrent() - self.lastTime;
        [self timerActionWithTimeInterval:(NSInteger)timeInterval];
        [self start];
    }
}


NSString *const MZCountDownDefaultNotification = @"MZCountDownDefaultNotification";

@end
