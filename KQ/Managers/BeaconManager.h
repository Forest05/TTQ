//
//  BeaconManager.h
//  DDX
//
//  Created by Forest on 14-9-24.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

#import "TTQBeacon.h"

@interface BeaconManager : NSObject<CLLocationManagerDelegate>{

    float _minDistance;
    float _maxDistance;

}

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong)  CLBeaconRegion *beaconRegion;
@property (nonatomic, strong) TTQBeacon *activatedBeacon;

+ (id)sharedInstance;

- (void)startRanging;
- (void)stopRanging;

- (void)openBeacon:(TTQBeacon*)beacon;
- (void)closeBeacon:(TTQBeacon*)beacon;


- (void)openArtBeacon:(TTQBeacon*)beacon;
- (void)closeArtBeacon:(TTQBeacon*)beacon;

@end
