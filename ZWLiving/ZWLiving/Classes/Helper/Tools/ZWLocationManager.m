//
//  ZWLocationManager.m
//  ZWLiving
//
//  Created by limin on 17/3/29.
//  Copyright © 2017年 君安信（北京）科技有限公司. All rights reserved.
//

#import "ZWLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface ZWLocationManager()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locManager;

@property(nonatomic,copy)LocationBlock block;

@end

@implementation ZWLocationManager

+(instancetype)sharedManager
{
    static ZWLocationManager *_instance = nil;
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        _instance = [[ZWLocationManager alloc] init];
    });
    
    return _instance;
}

-(instancetype)init
{
    if (self = [super init]) {
        _locManager = [[CLLocationManager alloc] init];
        // 设置精确度
        [_locManager setDesiredAccuracy:kCLLocationAccuracyBest];
        // 设置地位范围
        [_locManager setDistanceFilter:100.f];
        // 设置delegate
        _locManager.delegate = self;
        // 开启定位服务
        if ([CLLocationManager locationServicesEnabled]) {
            NSLog(@"定位服务可用");
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            
            if (status == kCLAuthorizationStatusNotDetermined) {
                [_locManager requestWhenInUseAuthorization];
            }
        }else
        {
            NSLog(@"去开启定位服务");
        }
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    CLLocationCoordinate2D coor = newLocation.coordinate;
    
    [ZWLocationManager sharedManager].lat = [@(coor.latitude) stringValue];
    
    [ZWLocationManager sharedManager].lon = [@(coor.longitude) stringValue];
    
    self.block([@(coor.latitude) stringValue],[@(coor.longitude) stringValue]);
    
    [self.locManager stopUpdatingLocation];
    
}

-(void)getGps:(LocationBlock)block
{
    self.block = block;
    [self.locManager startUpdatingLocation];
}


@end
