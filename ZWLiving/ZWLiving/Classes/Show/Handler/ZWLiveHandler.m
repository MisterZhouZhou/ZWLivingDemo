//
//  ZWLiveHandler.m
//  ZWLiving
//
//  Created by limin on 17/3/26.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import "ZWLiveHandler.h"
#import "ZWLocationManager.h"
#import "ZWAdvertise.h"
#import "HttpTool.h"
#import "ZWLive.h"

@implementation ZWLiveHandler
/**
 *  获取首页信息
 */
+ (void)executeGetShowLiveTasksWithSuccess:(SuccessBlock)success
                                    failed:(FailedBlock)failed{
    [HttpTool getWithPath:API_LiveGetTop params:nil success:^(id json) {
        if ([json[@"dm_error"] integerValue]) {
            failed(json[@"error_msg"]);
        }
        else{
            if (success) {
                success(json);
            }
        }
    } failure:^(NSError *error) {
        if (failed) {
            failed(error);
        }
    }];
}

/**
 *  获取热门直播信息
 */
+ (void)executeGetHotLiveTaskWithPage:(NSInteger)pageNum
                              success:(SuccessBlock)success
                               failed:(FailedBlock)failed {
    
    [HttpTool getWithPath:API_LiveGetTop params:@{@"uid":@"315"} success:^(id json) {
        
        NSInteger error = [json[@"dm_error"] integerValue];
        if (!error) {
            
            NSArray * lives = [ZWLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            success(lives);
            
        } else {
            
            failed(json);
            
        }
    } failure:^(NSError *error) {
        
        failed(error);
    }];
    
}


/**
 *  获取附近直播信息
 */
+ (void)executeNearLiveTaskWithSuccess:(SuccessBlock)success
                                failed:(FailedBlock)failed {
    
    ZWLocationManager *manager = [ZWLocationManager sharedManager];
//    NSDictionary * params = @{@"uid":@"85149891",
//                              @"latitude":@"40.090562",
//                              @"longitude":@"116.413353"
//                              };
    NSDictionary * params = @{@"uid":@"85149891",
                              @"latitude":manager.lat,
                              @"longitude":manager.lon
                              };
    
    [HttpTool getWithPath:API_NearLocation params:params success:^(id json) {
        
        NSInteger error = [json[@"dm_error"] integerValue];
        
        if (!error) {
            
            NSArray * lives = [ZWLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            success(lives);
            
        } else {
            
            failed(json);
            
        }
    } failure:^(NSError *error) {
        
        failed(error);
    }];
}

+(void)executeGet_AdvertiseTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed
{
    [HttpTool getWithPath:API_Advertise params:nil success:^(id json) {
        
        if ([json[@"dm_error"] integerValue]) {
            failed(json[@"error_msg"]);
        }else{
            ZWAdvertise *adver = [ZWAdvertise mj_objectWithKeyValues:[json[@"resources"] firstObject]];
            //返回信息正确的处理操作
            success(adver);
        }
    } failure:^(NSError *error) {
        failed(error);
    }];
}

@end
