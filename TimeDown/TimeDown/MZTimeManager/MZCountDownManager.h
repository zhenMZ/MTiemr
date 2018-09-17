//
//  MZCountDownManager.h
//  TupoApp
//
//  Created by zhen mz on 2018/8/29.
//  Copyright © 2018年 mz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *const MZCountDownDefaultNotification;

@interface MZCountDownManager : NSObject

/**
 init

 @param notificationName 发送通知的name(不传默认MZCountDownDefaultNotification)
 @return 实例
 */
- (instancetype)initWithManagerNotification:(NSString *)notificationName ;

/**
 开启倒计时
 */
- (void)start;


/**
 停止倒计时
 */
- (void)invalidate;


/**
 时间差
 */
@property (nonatomic, assign) NSInteger timeInterval;

/**
 刷新时间差
 */
- (void)reload;

@end
