//
//  AppManager.m
//  DDX
//
//  Created by Forest on 14-10-7.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "AppManager.h"

@implementation AppManager


+ (id)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
        
    });
    
    return sharedInstance;
}

- (id)init{
    if (self = [super init]) {

        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:TTQHallKey];
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        Hall *hall = [[Hall alloc] initWithDict:dict[@"hall"]];
        
        NSArray *imageTexts = dict[@"imageTexts"];
        for (NSDictionary *imageTextDict in imageTexts) {
            ImageText *it = [[ImageText alloc] initWithDict:imageTextDict];
            
            [hall.imageTexts addObject:it];
        }

        self.hall = hall;
    }
    
    return self;
}

@end
