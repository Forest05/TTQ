//
//  AppManager.m
//  DDX
//
//  Created by Forest on 14-10-7.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "AppManager.h"
#import "NetworkClient.h"

@implementation AppManager


+ (id)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
        
    });
    
    return sharedInstance;
}

- (Exhibition*)exhibition{

    return self.hall.defaultExhibition;
}

- (NSArray *)arts{
    return self.hall.defaultExhibition.arts;
}


- (id)init{
    if (self = [super init]) {
//
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:TTQHallKey];
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
       
        if (!ISEMPTY(dict)) {
            NSLog(@"if memory has json dict, config hall");
            
            [self configHallDict:dict];
            
            //抓一下
            
        }
        else {
            NSLog(@"if hasn't json dict, request from server");
            
            
//            [self requestHall];
        }
        
        
        [[NetworkClient sharedInstance] queryFirstUpdatedTimeWithBlock:^(NSDictionary *dict, NSError *error) {
            
//            NSLog(@"update # %@",dict);
            
            int remoteVersion = [dict[@"version"] intValue];
      
            int localVersion = [[NSUserDefaults standardUserDefaults]integerForKey:@"firstUpdate"];

             NSLog(@"local # %d, remoteVersion # %d",localVersion,remoteVersion);
            
            if (localVersion < remoteVersion) {
                
                [self requstHallWithVersion:remoteVersion];
            }
            
        }];

        
    }
    
    return self;
}

- (void)requestHall{
   
    L();
    
    [[NetworkClient sharedInstance] queryFirstTimeOpenedWithBlock:^(NSDictionary *dict, NSError *error) {
        
        
        //第一次载入app用
        [self configHallDict:dict];
        
        
        //保存hall到defaults中
        NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:dict];
        [[NSUserDefaults standardUserDefaults] setObject:dataSave forKey:TTQHallKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 把dict存到resource中去
        
       
//        NSData *jsonData = [NSJSONSerialization
//                            dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
//        
//        NSString *str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//        NSLog(@"json # %@",str);
        
        
        
        
    }];
    
}

- (void)requstHallWithVersion:(int)version{

    L();
    
    [[NetworkClient sharedInstance] queryFirstTimeOpenedWithBlock:^(NSDictionary *dict, NSError *error) {
        
        
        //第一次载入app用
        [self configHallDict:dict];
      
        //保存hall到defaults中
        NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:dict];
        [[NSUserDefaults standardUserDefaults] setObject:dataSave forKey:TTQHallKey];
        [[NSUserDefaults standardUserDefaults] setInteger:version forKey:@"firstUpdate"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        
        // 把dict存到resource中去
        
        
        //        NSData *jsonData = [NSJSONSerialization
        //                            dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        //
        //        NSString *str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        //
        //        NSLog(@"json # %@",str);
        
        
        
        
    }];
}

- (void)configHallDict:(NSDictionary*)dict{
    
    
    
    Hall *hall = [[Hall alloc] initWithDict:dict[@"hall"]];
    
    
    NSArray *imageTexts = dict[@"imageTexts"];
    for (NSDictionary *imageTextDict in imageTexts) {
        ImageText *it = [[ImageText alloc] initWithDict:imageTextDict];
        
        [hall.imageTexts addObject:it];
    }
    
    Exhibition *exhibition = [[Exhibition alloc] init];
    exhibition.id = hall.exhibitionId;
    exhibition.major = @"1";
    hall.defaultExhibition = exhibition;
    
    //arts
    NSArray *arts = dict[@"arts"];
    NSMutableArray *artArr = [NSMutableArray array];
    
    for (NSDictionary *dict in arts) {
        
        Art *art = [[Art alloc] initWithDict:dict];
        [art configBeaconWithUUID:[[NSUUID alloc] initWithUUIDString:hall.uuid] major:[exhibition.major integerValue]];
        
        [artArr addObject:art];
        
        // 如果art有beacon，那么就加入到map中
        if (!ISEMPTY(art.beacon)) {
            
//            NSLog(@"art # %@, beacon # %@",art,art.beacon);
            
            /// 为什么用beacon做key的时候
               [exhibition.artBeacons setObject:art forKey:[NSString stringWithInt:art.beacon.minorValue]];
            
//            NSLog(@"artBeacons # %@",exhibition.artBeacons);
        }

    }
    
    NSLog(@"artBeacons # %@",exhibition.artBeacons);
    
    hall.defaultExhibition.arts = artArr;
    
    //beacons
    
    self.hall = hall;

}

- (NSArray*)selectedArts:(NSArray*)artIds{

    return nil;
}
@end
