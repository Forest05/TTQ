//
//  BeaconManager.m
//  DDX
//
//  Created by Forest on 14-9-24.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "BeaconManager.h"
#import "AppManager.h"

#define MinDistance 1
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
        
//        NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"00000000-0000-0000-C000-000000000029"];
        self.beaconRegion = [[CLBeaconRegion alloc]initWithProximityUUID:uuid major:[appManager.hall.defaultExhibition.major intValue] identifier:uuid.UUIDString];
        
        _minDistance = [[NSUserDefaults standardUserDefaults] floatForKey:@"minDistance"];
        _maxDistance = [[NSUserDefaults standardUserDefaults] floatForKey:@"maxDistance"];
        
         NSLog(@"min # %f, max # %f",_minDistance,_maxDistance);
        
        
    }
    
    return self;
}

#pragma mark - locationDelegate
- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region{
    
    NSLog(@"did range beacons # %@",beacons);
    
    
    //判断接近那个beacon，
    
    
    
    if (self.activatedBeacon) {
    /// 如果存在激活的beacon，那么就监听这个beacon的距离, 超过就close
        
        CLBeacon *aBeacon = [self activatedCLBeaconFromArray:beacons];
        if (!aBeacon || aBeacon.accuracy > _maxDistance) {
            [self closeBeacon:self.activatedBeacon];
            self.activatedBeacon = nil;
        }
    }
    else{
    /// 如果不存在激活的beacon，就设定激活的beacon
        CLBeacon *closestBeacon = [self closestBeaconFromArray:beacons];
        
        NSLog(@"closest Beacon # %@",closestBeacon);
        
        if (closestBeacon && closestBeacon.accuracy < _minDistance) {
           
            self.activatedBeacon = [[TTQBeacon alloc] initWithCLBeacon:closestBeacon];
            NSLog(@"activeBeacon # %@",closestBeacon);
            
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
//    
//    if (beacon.minorValue == 1) {
//        [self openExhibitionBeacon:beacon];
//    }
//    else{
//        [self openArtBeacon:beacon];
//    }

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

//    CLBeacon *closestBeacon = [beacons firstObject];
    CLBeacon *closestBeacon;
    float minAccuracy = 999;
    for (CLBeacon *beacon in beacons) {
        float accuracy = beacon.accuracy;
        if (accuracy < 0) {
            break;
        }
       
        if ( accuracy < minAccuracy) {
            closestBeacon = beacon;
            minAccuracy = accuracy;
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
