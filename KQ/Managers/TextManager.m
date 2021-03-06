//
//  TextManager.m
//  DDX
//
//  Created by Forest on 14-10-15.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "TextManager.h"

@implementation TextManager

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
        _dict = [NSDictionary dictionaryWithContentsOfFile:[NSString filePathForResource:@"text2.plist"]];
        
//        NSLog(@"dict # %@",_dict);
    }
    
    return self;
}

- (NSString*)textWithKey:(NSString*)key{

    NSDictionary *valueDict = _dict[key];
    
    if (ISEMPTY(valueDict)) {
        return key;
    }
    
    NSString* value = valueDict[kLang];
    

    
    return value;
}

@end
