//
//  Beacon.m
//  DDX
//
//  Created by Forest on 14-9-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "TTQBeacon.h"

@implementation TTQBeacon

- (id)copyWithZone:(NSZone *)zone{
    TTQBeacon *beacon = [[TTQBeacon alloc] init];
    
    beacon.uuid = self.uuid;
    beacon.majorValue = self.majorValue;
    beacon.minorValue = self.minorValue;
    
    return beacon;
}

- (BOOL)isEqualToCLBeacon:(CLBeacon*)beacon{

    if ([[beacon.proximityUUID UUIDString] isEqualToString:[self.uuid UUIDString]] &&
        
        [beacon.major isEqual: @(self.majorValue)] &&
        
        [beacon.minor isEqual: @(self.minorValue)]){
    
        return YES;
    }
    else{
        return NO;
    }

}

- (id)initWithCLBeacon:(CLBeacon*)clb{
    
    TTQBeacon *beacon = [[TTQBeacon alloc] init];
    beacon.uuid = clb.proximityUUID;
    beacon.majorValue = [clb.major integerValue];
    beacon.minorValue = [clb.minor intValue];
    
    return beacon;
}

- (NSString*)description{

    NSMutableString *str = [NSMutableString stringWithString:[super description]];
    [str appendFormat:@" %@, %d, %d",self.uuid.UUIDString,self.majorValue,self.minorValue];
    
    return [str copy];
    
}
@end
