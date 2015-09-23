//
//  PMTimerManager.m
//  timeDemo
//
//  Created by goodheart on 15/9/23.
//  Copyright © 2015年 HSC. All rights reserved.
//

#import "PMTimerManager.h"

@implementation PMTimerManager

- (void)addCountDownWithMSecDuration:(float)duration eventHandler:(PMOneParameterBlock)eventBlock cancelBlock:(PMOneParameterBlock)cancelBlock{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), duration * NSEC_PER_MSEC, 0);
    
    dispatch_source_set_event_handler(timer, ^{
        eventBlock(timer);
    });
    
    dispatch_source_set_cancel_handler(timer, ^{
        cancelBlock(timer);
    });
    
    dispatch_resume(timer);
}

- (void)addCountDownWithSecDuration:(float)duration
                    eventHandler:(PMOneParameterBlock)eventBlock
                     cancelBlock:(PMOneParameterBlock)cancelBlock{
    [self addCountDownWithMSecDuration:duration * 1000
                         eventHandler:eventBlock
                          cancelBlock:cancelBlock];
}

@end
