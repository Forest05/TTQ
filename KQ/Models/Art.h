//
//  Art.h
//  DDX
//
//  Created by Forest on 14-9-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTQBeacon.h"

//艺术品
@interface Art : NSObject<NSCopying>


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
@property (nonatomic, copy) NSDictionary *dict;

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *exhibitionId;
@property (nonatomic, strong) NSString *authorId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *name_en;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *description_en;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *minor;

@property (nonatomic, strong) TTQBeacon *beacon;

- (id)initWithDict:(NSDictionary *)dict;

- (void)display;

// 如果有minor，就生成beacon
- (void)configBeaconWithUUID:(NSUUID*)uuid major:(int)major;
@end
