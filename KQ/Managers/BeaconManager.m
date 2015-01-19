//
//  BeaconManager.m
//  DDX
//
//  Created by Forest on 14-9-24.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "BeaconManager.h"
#import "AppManager.h"
#import "MobClick.h"

#define kBeanconNum 1

@interface BeaconManager()

- (CLBeacon*)closestBeaconFromArray:(NSArray*)beacons;
- (CLBeacon*)activatedCLBeaconFromArray:(NSArray*)beacons;

@end

@implementation BeaconManager

+ (id)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
        
    });
    
    return sharedInstance;
}



// AppManager 要在BeaconManager之前定义！
- (id)init{
    
    if (self = [super init]) {
        
        [self initLocationManager];
        
        AppManager *appManager = [AppManager sharedInstance];

        NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:appManager.hall.uuid];
        
//        NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"00000000-0000-0000-C000-000000000029"];
        self.beaconRegion = [[CLBeaconRegion alloc]initWithProximityUUID:uuid major:[appManager.hall.defaultExhibition.major intValue] identifier:uuid.UUIDString];
        
        
        _minDistance = [[MobClick getConfigParams:@"minDistance"] floatValue];
        _maxDistance = [[MobClick getConfigParams:@"maxDistance"] floatValue];
        
        if (_minDistance < 0.1) { // 如果友盟在线参数没有启动，默认值
            _minDistance = 0.5;
            _maxDistance = 1.5;
        }
        
        
         NSLog(@"min # %f, max # %f",_minDistance,_maxDistance);
        
        
    }
    
    return self;
}

- (void)initLocationManager{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if (isIOS8) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
}

#pragma mark - locationDelegate
- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region{
    
    
    NSLog(@"did range beacons # %@",beacons);
    
    if (!ISEMPTY(beacons) && isToolVersion()) { // 如果是工具版， 发送 beacon 信息以供调试
        [[NSNotificationCenter defaultCenter] postNotificationName:kListBeaconsNotificationKey object:beacons];
    }
    
    
    
    if (self.activatedBeacon) {
    /// 如果存在激活的beacon，那么就监听这个beacon的距离, 超过就close
        
        //取得beacon
        CLBeacon *aBeacon = [self activatedCLBeaconFromArray:beacons];
        
        //如果beacon不存在列表中（出错了，或一下子beacon关掉了）或是beacon的距离大于最大距离，都把激活的beacon关掉
        if (!aBeacon || aBeacon.accuracy > _maxDistance || aBeacon.accuracy == -1.0) {

            [self closeBeacon:self.activatedBeacon];
            self.activatedBeacon = nil;

        }
    }
    else{
    /// 如果不存在激活的beacon，就设定激活的beacon
        CLBeacon *closestBeacon = [self closestBeaconFromArray:beacons];
        
        NSLog(@"closest Beacon # %@",closestBeacon);
        
        if (!closestBeacon) {
            return;
        }
        
        // 如果最近的beacon的距离小于最小距离就激活
        if (closestBeacon.accuracy < _minDistance) {
           
            self.activatedBeacon = [[TTQBeacon alloc] initWithCLBeacon:closestBeacon];
            NSLog(@"activeBeacon # %@",closestBeacon);
            
            [self openBeacon:self.activatedBeacon];
        }

    }
    
    
}

#pragma mark - Fcns

//
//- (void)registerBeaconRegionWithUUID:(NSUUID *)proximityUUID andIdentifier:(NSString*)identifier {
//    
//    
//    
//    // Create the beacon region to be monitored.
//    
//    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc]
//                                    
//                                    initWithProximityUUID:proximityUUID
//                                    
//                                    identifier:identifier]; //
//    
//    
//    
//    // Register the beacon region with the location manager.
//    
//    [self.locationManager startMonitoringForRegion:beaconRegion];
//    
//}

- (void)startRanging{
    L();
    
    //B9407F30F5F8466EAFF925556B57FE6D

    
    self.activatedBeacon = nil;
    
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];

}

- (void)stopRanging{

    L();
    
    self.activatedBeacon = nil;
    
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
    
}
//


- (void)openBeacon:(TTQBeacon*)beacon{

     [self openArtBeacon:beacon];
}
- (void)closeBeacon:(TTQBeacon*)beacon{


    [self closeArtBeacon:beacon];
}

- (void)openArtBeacon:(TTQBeacon*)beacon{
//    L();
    [[NSNotificationCenter defaultCenter] postNotificationName:kOpenBeaconNotificationKey object:beacon];
}

- (void)closeArtBeacon:(TTQBeacon*)beacon{
    L();
    [[NSNotificationCenter defaultCenter] postNotificationName:kCloseBeaconNotificationKey object:beacon];
}


- (CLBeacon*)closestBeaconFromArray:(NSArray*)beacons{

//    NSLog(@"beacons # %@",beacons);

    CLBeacon *closestBeacon;
    float minAccuracy = 999;
    for (CLBeacon *beacon in beacons) {
        float accuracy = beacon.accuracy;
        if (accuracy < 0) {
            continue;
        }
       
        if ( accuracy < minAccuracy) {
            closestBeacon = beacon;
            minAccuracy = accuracy;
        }
    }
    
    return closestBeacon;
}

- (CLBeacon*)activatedCLBeaconFromArray:(NSArray*)beacons{

    for (CLBeacon *beacon in beacons) {
        if ([self.activatedBeacon isEqualToCLBeacon:beacon]) {
            return beacon;
        }
    }
    
    return nil;
}

- (void)test{
    L();
    
//    [self startRanging];
    
}

@end
