//
//  Beacon.h
//  DDX
//
//  Created by Forest on 14-9-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface TTQBeacon : NSObject<NSCopying>

@property (nonatomic, strong) NSUUID *uuid;
@property (nonatomic, assign) int majorValue;
@property (nonatomic, assign) int minorValue;

- (BOOL)isEqualToCLBeacon:(CLBeacon*)clb;


@end
