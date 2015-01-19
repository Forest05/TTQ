//
//  TextManager.h
//  DDX
//
//  Created by Forest on 14-10-15.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextManager : NSObject{

    NSDictionary *_dict;
    
}

+ (id)sharedInstance;

- (NSString*)textWithKey:(NSString*)key;

@end
