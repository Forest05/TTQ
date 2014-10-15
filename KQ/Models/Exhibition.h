//
//  Exhibition.h
//  DDX
//
//  Created by Forest on 14-9-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Author.h"

//展览
@interface Exhibition : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, strong) NSString *hallId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *name_en;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *description_en;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *beginDate;
@property (nonatomic, strong) NSString *endDate;

@property (nonatomic, strong) NSString *major;

@property (nonatomic, strong) Author *curator;
@property (nonatomic, strong) NSArray *arts; //key是art，obj是
@property (nonatomic, strong) NSMutableDictionary *artBeacons; //key是beacon的minor， obj是art


- (id)initWithDict:(NSDictionary *)dict;

- (void)display;




@end
