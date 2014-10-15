//
//  Author.m
//  DDX
//
//  Created by Forest on 14-9-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "Author.h"

@implementation Author

static NSArray *keys;
- (id)initWithDict:(NSDictionary *)dict{
    
    if (self = [self init]) {
        
            
        if (!keys) {
            keys = @[@"id",@"name",@"name_en",@"description_en",@"avatarUrl"];
        }
        
        for (NSString *key in keys) {
            [self setValue:dict[key] forKey:key];
        }
        self.desc = dict[@"description"];
        
        
        
    }
    return self;
}

@end
