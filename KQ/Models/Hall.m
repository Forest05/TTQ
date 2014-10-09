//
//  Hall.m
//  DDX
//
//  Created by Forest on 14-9-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "Hall.h"

@implementation Hall

static NSArray *keys;

- (id)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {

        if (!keys) {
            keys = @[@"id",@"name",@"name_en"];
        }
        
        for (NSString *key in keys) {
            [self setValue:dict[key] forKey:key];
        }

        self.imageTexts = [NSMutableArray array];
    }
    
    return self;
}

- (void)display{
    
//    NSArray *keys = @[@"id",@"name",@"name_en"];
    NSLog(@"--------------Begin Display Hall # %@------------\n",self);
    for (NSString *key in keys) {
        NSLog(@"%@ => %@",key, [self valueForKey:key]);
    }
    
    NSLog(@"imageTexts # %@",self.imageTexts);
    NSLog(@"--------------End Display----------------");
}

@end
