//
//  ImageText.m
//  DDX
//
//  Created by Forest on 14-10-7.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ImageText.h"

//static NSArray *keys = @[@"number",@"title",@"title_en",@"text",@"text_en"];


@implementation ImageText


static NSArray *keys;

- (id)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {

        //keys只会被init一次
        if (!keys) {
            keys = @[@"number",@"title",@"title_en",@"text",@"text_en",@"imageUrl"];
        }
        
        for (NSString *key in keys) {
            [self setValue:dict[key] forKey:key];
        }
    }
    
    return self;
}

- (void)display{
    
    NSLog(@"--------------Begin Display ImageText # %@------------\n",self);
    for (NSString *key in keys) {
        NSLog(@"%@ => %@",key, [self valueForKey:key]);
    }
    NSLog(@"--------------End Display----------------");
}
@end
