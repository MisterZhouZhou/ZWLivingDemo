//
//  AppDelegate.m
//  ZWLiving
//
//  Created by limin on 17/3/25.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "ZWTabbarViewController.h"
#import "ZWLocationManager.h"
#import "ZWAdvertiseView.h"
#import "AppDelegate+UMeng.h"
#import "ZWUserHelper.h"
#import "ZWLoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self registerUMDefaults];
    
    UIViewController *mainVC = [[UIViewController alloc] init];
    if ([ZWUserHelper isAutoLogin]) {
        mainVC = [[ZWTabbarViewController alloc] init];
    }else
    {
        mainVC = [[ZWLoginViewController alloc] init];
    }
    
    //root 
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = mainVC;
    [self.window makeKeyAndVisible];
    
    // 进行定位
    [[ZWLocationManager sharedManager]getGps:^(NSString *lat, NSString *lon) {
        NSLog(@"%@  %@",lat,lon);
    }];
    
    // 显示广告
    ZWAdvertiseView *adView = [ZWAdvertiseView loadAdvertiseView];
    [self.window addSubview:adView];
    
    // 3d touch
    [self setup3DTouch:application];
    return YES;
}

- (void)setup3DTouch:(UIApplication *)application
{
    /**
     type 该item 唯一标识符
     localizedTitle ：标题
     localizedSubtitle：副标题
     icon：icon图标 可以使用系统类型 也可以使用自定义的图片
     userInfo：用户信息字典 自定义参数，完成具体功能需求
     */
    //    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"标签.png"];
    UIApplicationShortcutIcon *cameraIcon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
    UIApplicationShortcutItem *cameraItem = [[UIApplicationShortcutItem alloc] initWithType:@"com.qianguajia.test" localizedTitle:@"拍照" localizedSubtitle:@"上传" icon:cameraIcon userInfo:nil];
    //
    //    /** 将items 添加到app图标 */
    application.shortcutItems = @[cameraItem];
}


// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
