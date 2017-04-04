//
//  ZWTimerManager.h
//  ZWLiving
//
//  Created by limin on 17/3/30.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWTimerManager : NSObject

+ (void)timerWithAnimationTime:(NSInteger)timeout timeEvent:(void(^)(NSInteger time))event timeoutEvent:(void(^)())endevent;

@end
