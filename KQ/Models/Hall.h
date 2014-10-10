//
//  Hall.h
//  DDX
//
//  Created by Forest on 14-9-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageText.h"
#import "Exhibition.h"
#import "Art.h"

// 展馆
@interface Hall : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *name_en;
@property (nonatomic, strong) NSString *postUrl;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *exhibitionId;
@property (nonatomic, strong) NSString *uuid;

@property (nonatomic, strong) NSMutableDictionary *exhibitions; // key是exhibition的id，如果没有载入的话，value为nsnull，否则为exhibition
@property (nonatomic, strong) NSMutableArray *imageTexts;  //这个肯定会初始化
@property (nonatomic, strong) Exhibition *defaultExhibition;


- (id)initWithDict:(NSDictionary *)dict;

- (void)display;
@end
