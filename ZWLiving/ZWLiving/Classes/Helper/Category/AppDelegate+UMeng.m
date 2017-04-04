//
//  AppDelegate+UMeng.m
//  ZWLiving
//
//  Created by limin on 17/4/4.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import "AppDelegate+UMeng.h"


static NSString *const servicehost =@"http://question.qianguajia.com";
@implementation AppDelegate (UMeng)

-(void)registerUMDefaults
{
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"56cd154067e58e7224000c17"];
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxd88300d08985a2a0" appSecret:@"5f366c312a85eb99c644d598d636a7e9" redirectURL:servicehost];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106055216"/*设置QQ平台的appID*/  appSecret:@"atuSVsu0sZfNWAv3" redirectURL:servicehost];
}

@end
