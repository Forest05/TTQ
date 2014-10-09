//
//  ImageText.h
//  DDX
//
//  Created by Forest on 14-10-7.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageText : NSObject

@property (nonatomic, strong) NSString *number; //序号
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *title_en;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *text_en;
@property (nonatomic, strong) NSString *imageUrl;


- (id)initWithDict:(NSDictionary *)dict;

- (void)display;

@end
