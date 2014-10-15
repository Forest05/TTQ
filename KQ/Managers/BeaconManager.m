//
//  BeaconManager.m
//  DDX
//
//  Created by Forest on 14-9-24.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "BeaconManager.h"
#import "AppManager.h"

#define MinDistance 1.0
#define MaxDistance 1.5

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
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        
        
        
        AppManager *appManager = [AppManager sharedInstance];
        NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:appManager.hall.uuid];
        
        self.beaconRegion = [[CLBeaconRegion alloc]initWithProximityUUID:uuid major:[appManager.hall.defaultExhibition.major intValue] identifier:uuid.UUIDString];
        
    }
    
    return self;
}

#pragma mark - locationDelegate
- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region{
    
    NSLog(@"did range beacons # %@",beacons);
    //    NSLog(@"item beacons # %@",self.itemBeacons);
    
    //判断接近那个beacon，
    
    // 这里的beacon是否是按照最近的？
//    for (CLBeacon *beacon in beacons) {
//        
//        NSLog(@"minor # %d, accuricy # %f",[beacon.minor intValue],beacon.accuracy);
//        
//        
//    }
    
    
    if (self.activatedBeacon) {
    /// 如果存在激活的beacon，那么就监听这个beacon的距离, 超过就close
        
        CLBeacon *aBeacon = [self activatedCLBeaconFromArray:beacons];
        if (!aBeacon || aBeacon.accuracy > MaxDistance) {
            [self closeBeacon:self.activatedBeacon];
        }
    }
    else{
    /// 如果不存在激活的beacon，就设定激活的beacon
        CLBeacon *closestBeacon = [self closestBeaconFromArray:beacons];
        
        NSLog(@"closest Beacon # %@",closestBeacon);
        
        if (closestBeacon.accuracy < MinDistance) {
            self.activatedBeacon = [[TTQBeacon alloc] initWithCLBeacon:closestBeacon];
            [self openBeacon:self.activatedBeacon];
        }

    }
    
    
}

#pragma mark - Fcns

//
- (void)registerBeaconRegionWithUUID:(NSUUID *)proximityUUID andIdentifier:(NSString*)identifier {
    
    
    
    // Create the beacon region to be monitored.
    
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc]
                                    
                                    initWithProximityUUID:proximityUUID
                                    
                                    identifier:identifier]; //
    
    
    
    // Register the beacon region with the location manager.
    
    [self.locationManager startMonitoringForRegion:beaconRegion];
    
}

- (void)startRanging{
    L();
    
    //B9407F30F5F8466EAFF925556B57FE6D
//    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
//    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"00000000-0000-0000-C000-000000000028"];
    
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
    L();
    [[NSNotificationCenter defaultCenter] postNotificationName:kOpenBeaconNotificationKey object:beacon];
}

- (void)closeBeacon:(TTQBeacon*)beacon{

    [[NSNotificationCenter defaultCenter] postNotificationName:kCloseBeaconNotificationKey object:beacon];
}

- (CLBeacon*)closestBeaconFromArray:(NSArray*)beacons{

    NSLog(@"beacons # %@",beacons);

    CLBeacon *closestBeacon = [beacons firstObject];
    for (CLBeacon *beacon in beacons) {
        float accuracy = beacon.accuracy;
        if (accuracy > 0 && accuracy < closestBeacon.accuracy) {
            closestBeacon = beacon;
        }
    }
    
    return closestBeacon;
}

- (CLBeacon*)activatedCLBeaconFromArray:(NSArray*)beacons{

//    CLBeacon *aBeacon;
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
