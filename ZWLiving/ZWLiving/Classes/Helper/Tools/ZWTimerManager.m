//
//  ZWTimerManager.m
//  ZWLiving
//
//  Created by limin on 17/3/30.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import "ZWTimerManager.h"

@implementation ZWTimerManager

+ (void)timerWithAnimationTime:(NSInteger)outSends timeEvent:(void(^)(NSInteger time))event timeoutEvent:(void(^)())endevent{
    __block NSInteger timeout = outSends;
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (timeout <= 0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if (endevent) {
                    endevent();
                }
            });
        }
        else{
            timeout --;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (event) {
                    event(timeout);
                }
            });
        }
    });
    dispatch_resume(timer);
}

@end
