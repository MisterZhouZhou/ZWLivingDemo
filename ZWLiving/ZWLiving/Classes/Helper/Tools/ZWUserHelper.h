//
//  ZWUserHelper.h
//  ZWLiving
//
//  Created by limin on 17/4/4.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWUserHelper : NSObject

+ (instancetype)sharedUser;

@property (nonatomic, copy) NSString * username;

@property (nonatomic, copy) NSString * iconUrl;

+ (BOOL)isAutoLogin;

+ (void)saveUser;


@end
