//
//  PMTimerManager.h
//  timeDemo
//
//  Created by goodheart on 15/9/23.
//  Copyright © 2015年 HSC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PMOneParameterBlock)(id varOne);

@interface PMTimerManager : NSObject
/**
 *  @brief 添加 秒级 倒计时
 *  @param duration    倒计时间隔
 *  @param eventBlock  事件处理
 *  @param cancelBlock 取消处理
 */
- (void)addCountDownWithSecDuration:(float)duration
                    eventHandler:(PMOneParameterBlock)eventBlock
                     cancelBlock:(PMOneParameterBlock)cancelBlock;
/**
 *  @brief  添加 微秒级 倒计时
 */
- (void)addCountDownWithMSecDuration:(float)duration
                        eventHandler:(PMOneParameterBlock)eventBlock
                         cancelBlock:(PMOneParameterBlock)cancelBlock;

@end
