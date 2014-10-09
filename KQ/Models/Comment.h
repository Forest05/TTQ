//
//  Comment.h
//  KQ
//
//  Created by AppDevelopper on 14-6-3.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

//评论
@interface Comment : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *peopleId;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *publishedAt;


@end
