//
//  Author.h
//  DDX
//
//  Created by Forest on 14-9-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

//作者
@interface Author : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *name_en;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *description_en;
@property (nonatomic, copy) NSString *avatarUrl;


- (id)initWithDict:(NSDictionary *)dict;

@end
