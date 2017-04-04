//
//  ZLYCacheHelper.m
//  Live
//
//  Created by 朱梁瑜 on 2017/3/20.
//  Copyright © 2017年 朱梁瑜. All rights reserved.
//

#import "ZWCacheHelper.h"

#define advertiseImage @"adImage"

@implementation ZWCacheHelper

+(NSString *)getAdvertise{
    return [[NSUserDefaults standardUserDefaults] objectForKey:advertiseImage];
}


+(void)setAdvertise:(NSString *)adImage{
    [[NSUserDefaults standardUserDefaults] setObject:adImage forKey:advertiseImage];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
