//
//  BeaconManager.m
//  DDX
//
//  Created by Forest on 14-9-24.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "BeaconManager.h"
#import "AppManager.h"

@implementation BeaconManager

+ (id)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
        
    });
    
    return sharedInstance;
}

- (NSArray*)itemBeacons{

    if (!_itemBeacons) {
       _itemBeacons = [[[[AppManager sharedInstance] exhibition] artBeacons] allKeys];

    }
    return _itemBeacons;
}

// AppManager 要在BeaconManager之前定义！
- (id)init{
    
    if (self = [super init]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        
//        self.itemBeacons = [[[[AppManager sharedInstance] exhibition] artBeacons] allKeys];
//        NSLog(@"itemBeacons # %@",self.itemBeacons);
        
        [self startRanging];
    }
    
    return self;
}


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
    
//    NSString *uuid = [App]
    
    AppManager *appManager = [AppManager sharedInstance];
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:appManager.hall.uuid];

    
//    CLBeaconRegion * br = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:uuid.UUIDString];
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc]initWithProximityUUID:uuid major:[appManager.hall.defaultExhibition.major intValue] identifier:uuid.UUIDString];
    
    NSLog(@"beaconRegion # %@",beaconRegion);
    
    [self.locationManager startRangingBeaconsInRegion:beaconRegion];

}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region{

    NSLog(@"did range beacons # %@",beacons);
//    NSLog(@"item beacons # %@",self.itemBeacons);
    
    //判断接近那个beacon，
//    NSArray *exhibitionBeacons = [[[[AppManager sharedInstance] exhibition] artBeacons] allKeys];
    for (CLBeacon *beacon in beacons) {
        NSLog(@"minor # %d, accuricy # %f",[beacon.minor intValue],beacon.accuracy);
    }
}

- (void)test{
    L();
    
//    [self startRanging];
    
}

@end
