//
//  NetworkClient.h
//  Makers
//
//  Created by AppDevelopper on 14-5-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import <CoreLocation/CoreLocation.h>

#ifdef DEBUG



#define RESTHOST @"http://115.29.148.47/ttq/index.php/api1/"


//#define RESTHOST @"http://localhost/ttq/index.php/api1/"


#else

#define RESTHOST @"http://115.29.148.47/ttq/index.php/api1/"

#endif


@interface NetworkClient : NSObject{
    AFHTTPRequestOperationManager *_clientManager;
}


+ (id)sharedInstance;



- (void)queryFirstTimeOpenedWithBlock:(IdResultBlock)block;


/**
 *	@brief 获取用户个人信息
 *
 */
- (void)queryUser:(NSString*)uid block:(IdResultBlock)block;

- (void)queryUpdateAvatar:(NSString*)uid image:(UIImage*)image block:(IdResultBlock)block;

- (void)queryFirstUpdatedTimeWithBlock:(IdResultBlock)block;
/**
 *	@brief	用户注册登录
 */

- (void)registerWithDict:(NSDictionary*)info block:(IdResultBlock)block;
- (void)loginWithUsername:(NSString*)username password:(NSString*)password block:(IdResultBlock)block;


- (void)getWithUrl:(NSString*)url parameters:(NSDictionary*)parameters block:(IdResultBlock)block;
- (void)postWithUrl:(NSString*)url parameters:(NSDictionary*)parameters block:(IdResultBlock)block;
- (void)putWithUrl:(NSString*)url parameters:(NSDictionary*)parameters block:(IdResultBlock)block;
- (void)deleteWithUrl:(NSString*)url parameters:(NSDictionary*)parameters block:(IdResultBlock)block;

- (void)test;

@end
