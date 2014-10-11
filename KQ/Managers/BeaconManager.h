//
//  BeaconManager.h
//  DDX
//
//  Created by Forest on 14-9-24.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>
@interface BeaconManager : NSObject<CLLocationManagerDelegate>{

}

@property (nonatomic, strong) NSArray *itemBeacons;
@property (nonatomic, strong) CLLocationManager *locationManager;

+ (id)sharedInstance;

@end
