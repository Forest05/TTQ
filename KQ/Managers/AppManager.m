//
//  AppManager.m
//  DDX
//
//  Created by Forest on 14-10-7.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "AppManager.h"

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

        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:TTQHallKey];
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
       
        if (!ISEMPTY(dict)) {
            [self configHallDict:dict];
        }
        else{
//            NSLog(@"dict # %@",dict);
        }
        
    }
    
    return self;
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
@end
