//
//  Exhibition.m
//  DDX
//
//  Created by Forest on 14-9-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "Exhibition.h"

@implementation Exhibition

- (id)initWithDict:(NSDictionary *)dict{
    
    if (self = [self init]) {
        
    }
    return self;
}

- (id)init{
    if (self = [super init]) {
      self.artBeacons = [NSMutableDictionary dictionary];   
    }
    return self;
}

- (void)display{
    
}
@end
