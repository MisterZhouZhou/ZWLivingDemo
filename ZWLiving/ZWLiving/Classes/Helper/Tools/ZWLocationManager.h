//
//  ZWLocationManager.h
//  ZWLiving
//
//  Created by limin on 17/3/29.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^LocationBlock)(NSString *lat,NSString *lon);
@interface ZWLocationManager : NSObject

+(instancetype)sharedManager;

-(void)getGps:(LocationBlock)block;

@property(nonatomic,copy)NSString *lat;

@property(nonatomic,copy)NSString *lon;

@end
