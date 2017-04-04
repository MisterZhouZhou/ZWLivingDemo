//
//  ZWLiveHandler.h
//  ZWLiving
//
//  Created by limin on 17/3/26.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import "ZWBaseHandler.h"

@interface ZWLiveHandler : ZWBaseHandler

/**
 *  获取首页信息
 */
+ (void)executeGetShowLiveTasksWithSuccess:(SuccessBlock)success
                                failed:(FailedBlock)failed;

/**
 *  获取热门直播信息
 */
+ (void)executeGetHotLiveTaskWithPage:(NSInteger)pageNum
                              success:(SuccessBlock)success
                               failed:(FailedBlock)failed;

+ (void)executeNearLiveTaskWithSuccess:(SuccessBlock)success
                                failed:(FailedBlock)failed;

+(void)executeGet_AdvertiseTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;
@end
