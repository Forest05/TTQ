//
//  Base64AndImageHelp.h
//  DDX
//
//  Created by Forest on 14-10-16.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface Base64AndImageHelp : NSObject
- (NSString*)encodeURL:(NSString *)string;
+(id)mydataWithBase64EncodedString:(NSString *)string ;

@end
