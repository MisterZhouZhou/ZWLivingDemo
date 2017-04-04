//
//  ZWUserHelper.m
//  ZWLiving
//
//  Created by limin on 17/4/4.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import "ZWUserHelper.h"

@implementation ZWUserHelper
+ (instancetype)sharedUser {
    
    static ZWUserHelper * userhelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userhelper = [[ZWUserHelper alloc] init];
    });
    return userhelper;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        _iconUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"iconUrl"];
        
    }
    return self;
}

+ (BOOL)isAutoLogin {
    
    if ([ZWUserHelper sharedUser].username.length == 0) {
        return NO;
    }
    return YES;
}

+ (void)saveUser {

    [[NSUserDefaults standardUserDefaults] setObject:[ZWUserHelper sharedUser].username forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:[ZWUserHelper sharedUser].iconUrl forKey:@"iconUrl"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end
