//
//  AppManager.m
//  DDX
//
//  Created by Forest on 14-10-7.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "AppManager.h"
#import "NetworkClient.h"
#import "LibraryManager.h"
#import "TextManager.h"
#import "TTQRootViewController.h"

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
//        NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:TTQHallKey];
//        
//        NSLog(@"data # %@",data);
//        
//        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];

//        NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:TTQHallKey];
        
//        NSLog(@"str # %@",str);
        
//        NSData *data = [NSData datawith]
        
        NSDictionary *dict = loadArchived(@"hall");
//        NSLog(@"dict # %@",dict);
        
//        NSDictionary *dict;
        if (!ISEMPTY(dict)) {
            NSLog(@"if memory has json dict, config hall");
            
            [self configHallDict:dict];
            
        }
        else{
            NSLog(@"first time, load data from txt");
            NSString *filePath = [NSString filePathForResource:@"3.txt"];
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:nil];
            
//            NSLog(@"filePath # %@, dict # %@",filePath,dict);
            
            [self configHallDict:dict];
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


- (void)requstHallWithVersion:(int)version{

    L();
    
    [[NetworkClient sharedInstance] queryFirstTimeOpenedWithBlock:^(NSDictionary *dict, NSError *error) {
        
        
        //第一次载入app用
        [self configHallDict:dict];
      
        //保存hall到defaults中
//        NSData *dataSave = [NSKeyedArchiver archivedDataWithRootObject:dict];
        
//        NSLog(@"dataSave # %@",dataSave);
        
//        NSData *jsonData = [NSJSONSerialization
//                            dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
//        
//        NSString *str = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
//        
//        [[NSUserDefaults standardUserDefaults] setObject:str forKey:TTQHallKey];

        saveArchived(dict, @"hall");
        
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
    
    L();
    
    //param
    
    NSDictionary *params = dict[@"params"];
    
//    NSLog(@"params # %@",params);
    
    float minDistance = [params[@"minDistance"] floatValue];
    float maxDistance = [params[@"maxDistance"] floatValue];
//    NSLog(@"min # %f, max # %f",minDistance,maxDistance);
    
    if (minDistance * maxDistance >0) {
        
        [[NSUserDefaults standardUserDefaults] setFloat:minDistance forKey:@"minDistance"];
        [[NSUserDefaults standardUserDefaults] setFloat:maxDistance forKey:@"maxDistance"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
    Hall *hall = [[Hall alloc] initWithDict:dict[@"hall"]];
    
    
    NSArray *imageTexts = dict[@"imageTexts"];
    for (NSDictionary *imageTextDict in imageTexts) {
        ImageText *it = [[ImageText alloc] initWithDict:imageTextDict];
        
        [hall.imageTexts addObject:it];
    }
    

    
    Exhibition *exhibition = [[Exhibition alloc] initWithDict:dict[@"exhibition"]];
    hall.defaultExhibition = exhibition;
    
    //arts
    NSArray *arts = dict[@"arts"];
    NSMutableArray *artArr = [NSMutableArray array];
//    NSLog(@"artArr # %@",artArr);
    
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
    
//    NSLog(@"artBeacons # %@",exhibition.artBeacons);
    
    hall.defaultExhibition.arts = artArr;
    
    //beacons
    
    self.hall = hall;

}

- (NSArray*)selectedArts:(NSArray*)artIds{

    return nil;
}

- (Art*)artWithTTQBeacon:(TTQBeacon*)beacon{
    
    NSDictionary *beaconArts = self.exhibition.artBeacons;
    
    NSString *beaconMinor = [NSString stringWithInt:beacon.minorValue];
    Art *art = beaconArts[beaconMinor];
    
    return art;
}

- (void)shareArt:(Art*)art{
    LibraryManager *mng = [LibraryManager sharedInstance];
    NSString *serialNumber = art.serialNumber;
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"art_%@.jpg",serialNumber]];
    NSString *text = isZH?art.name:art.name_en;
    
    
    [mng shareWithText:[NSString stringWithFormat:@"%@ %@",text,lang(@"喜欢这次的展出《石头、木头和天堂症候群》@1933当代艺术空间")] image:image delegate:[TTQRootViewController sharedInstance]];
}
@end
