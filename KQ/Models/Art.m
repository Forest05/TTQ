//
//  Art.m
//  DDX
//
//  Created by Forest on 14-9-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "Art.h"

@implementation Art

/**
 "id": "1",
 "exhibitionId": "1",
 "authorId": null,
 "name": "作品1",
 "name_en": null,
 "description": "如果你的大数据表更新很频繁,建议用innodb,这个是基于行锁定的",
 "description_en": null,
 "imgUrl": "http://www.1933shanghai.com/uploads/yanhui/20140415/1397542691.JPG",
 "minor": "1"
 */


static NSArray *keys;

- (id)initWithDict:(NSDictionary *)dict{
    
    if (self = [self init]) {
        
        self.dict = dict;
        
        if (!keys) {
            keys = @[@"id",@"exhibitionId",@"authorId",@"name",@"name_en",@"description_en",@"imgUrl",@"minor"];
        }
        
        for (NSString *key in keys) {
            [self setValue:dict[key] forKey:key];
        }
        self.desc = dict[@"description"];

        self.index = self.id;
        
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    Art *art = [[Art alloc] initWithDict:self.dict];
    
    return art;
}

- (void)configBeaconWithUUID:(NSUUID*)uuid major:(int)major{

    if (!ISEMPTY(self.minor)) {
        self.beacon = [[TTQBeacon alloc] init];
        self.beacon.uuid = uuid;
        self.beacon.majorValue = major;
        self.beacon.minorValue = [self.minor integerValue];
        
    }
}



- (void)display{
    
    NSLog(@"--------------Begin Display %@ # %@------------\n",NSStringFromClass(self.class),self);
    for (NSString *key in keys) {
        NSLog(@"%@ => %@",key, [self valueForKey:key]);
    }
    
    NSLog(@"desc => %@",self.desc);
    NSLog(@"--------------End Display----------------");
}

@end
