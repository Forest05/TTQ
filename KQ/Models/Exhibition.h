//
//  Exhibition.h
//  DDX
//
//  Created by Forest on 14-9-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

//展览
@interface Exhibition : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, strong) NSArray *arts; //key是art，obj是
@property (nonatomic, strong) NSDictionary *beacons; //key是art的id， obj是CLBeaconRegion

- (id)initWithDict:(NSDictionary *)dict;

- (void)display;


@end
