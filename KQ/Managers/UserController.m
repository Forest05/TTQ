//
//  UserController.m
//  PushDemo
//
//  Created by AppDevelopper on 14-4-21.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "UserController.h"
#import <MapKit/MapKit.h>



@interface UserController (){

    
}


@end


@implementation UserController

- (void)setCity:(NSString *)city{

    [[NSUserDefaults standardUserDefaults] setObject:city forKey:@"city"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString*)city{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"city"];
}

- (void)setAvatar:(UIImage *)avatar{

    _avatar = avatar;
    
//    [_networkClient queryUpdateAvatar:self.uid image:avatar block:]
//    L();
}

#pragma mark - Init

+ (id)sharedInstance {
    static dispatch_once_t once;
    
    static id sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // user login! username, password, session
        
        _networkClient = [NetworkClient sharedInstance];
        
        
        if (!ISEMPTY([[NSUserDefaults standardUserDefaults] objectForKey:@"uid"])) {

            [self loadUser];
        }
        
//        self.checkinLocation = [[CLLocation alloc] initWithLatitude:31.02 longitude:121.02];
        

        
    }
    return self;
}



#pragma mark - Location

- (void) setupLocationManager {
   
    _locationManager = [[CLLocationManager alloc] init] ;
    if ([CLLocationManager locationServicesEnabled]) {
        //        NSLog( @"Starting CLLocationManager" );
        _locationManager.delegate = self;
        _locationManager.distanceFilter = 500;
        //        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        _locationManager.activityType = CLActivityTypeOther;
        [_locationManager startUpdatingLocation];
        
        //        [_locationManager startMonitoringSignificantLocationChanges];
    } else {
        NSLog( @"Cannot Starting CLLocationManager" );
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    L();
    
    _checkinLocation = newLocation;
    
}

- (CLLocationDistance)distanceFromLocation:(CLLocation*)location{
    return [_checkinLocation distanceFromLocation:location];
}

#pragma mark - Fcns

- (void)loadUser{
    
//    L();
    
    self.uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];

//    self.uid = @"2";

    /// 需要载入user
    [_networkClient queryUser:self.uid block:^(NSDictionary *dict, NSError *error) {
     
//        NSLog(@"dict # %@",dict);
        
        if (!ISEMPTY(dict)) {
            self.people = [People peopleWithDict:dict];
        }
        
        
    }];
}

- (BOOL)isLogin{

    
    if (self.uid) {
        return YES;
    }
    else
        return NO;
}



- (void)registerWithUserInfo:(NSDictionary*)userInfo block:(BooleanResultBlock)block{
    
    [[NetworkClient sharedInstance] registerWithDict:userInfo block:^(NSDictionary *dict, NSError *error) {
        
        if (!ISEMPTY(dict)) {
            
//            [self didLoginWithUid:dict[@"objectId"] token:dict[@"sessionToken"]];
            self.uid = dict[@"id"];
            [[NSUserDefaults standardUserDefaults]setObject:self.uid forKey:@"uid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self loadUser];

            
            block(YES,nil);
            
        }
        else{
            block(NO,error);
        }
        
    }];

    
}


- (void)loginWithEmail:(NSString*)email pw:(NSString*)pw block:(BooleanResultBlock)block{
    
    [[NetworkClient sharedInstance] loginWithUsername:email password:pw block:^(NSDictionary *dict, NSError *error) {
        
        if (!ISEMPTY(dict)) {
            
//            NSLog(@"login user # %@",dict);
            
            self.uid = dict[@"id"];
            [[NSUserDefaults standardUserDefaults]setObject:self.uid forKey:@"uid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self loadUser];
            
            block(YES,nil);
        }
        else{
            block(NO,error);
        }
    }];

}

- (void)didLoginWithUid:(NSString*)uid token:(NSString*)token{
    self.uid = uid;
    self.sessionToken = token;
    
    [[NSUserDefaults standardUserDefaults]setObject:self.uid forKey:@"uid"];

    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self loadUser];
    
}

- (void)requestPasswordResetForEmailInBackground:(NSString*)email block:(BooleanResultBlock)block{
    
//    [_engine requestPasswordResetForEmailInBackground:email block:block];
}

- (void)logout{
    
    self.uid = nil;
//    self.sessionToken = nil;
    
    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"uid"];
//    [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
  
    
}



#pragma mark - Test
- (void)test{
    L();

//    [self loadUser];
    
//    
//    MKDistanceFormatter *formatter = [[MKDistanceFormatter alloc] init];
//    formatter.units = MKDistanceFormatterUnitsMetric;
//    NSLog(@"%@", [formatter stringFromDistance:distance]); // 535 miles
}
@end
