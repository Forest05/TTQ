//
//  AppManager.h
//  DDX
//
//  Created by Forest on 14-10-7.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Hall.h"


@interface AppManager : NSObject

@property (nonatomic, strong) Hall *hall;

+ (id)sharedInstance;

@end
