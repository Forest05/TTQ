//
//  Art.h
//  DDX
//
//  Created by Forest on 14-9-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

//艺术品
@interface Art : NSObject

@property (nonatomic, copy) NSString *id;

- (id)initWithDict:(NSDictionary *)dict;

- (void)display;

@end
