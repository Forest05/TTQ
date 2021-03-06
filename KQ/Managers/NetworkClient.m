//
//  NetworkClient.m
//  Makers
//
//  Created by AppDevelopper on 14-5-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "NetworkClient.h"

#import "ErrorManager.h"



#define api_firstTimeOpened  [RESTHOST stringByAppendingFormat:@"/firstTimeOpened"]

#define api_updatedTime      [RESTHOST stringByAppendingFormat:@"/updatedTime"]

//用户登录
#define api_login               [RESTHOST stringByAppendingString:@"/login"]

//获取用户，用户注册
#define api_user                [RESTHOST stringByAppendingFormat:@"/user"]


#define api_updateAvatar         [RESTHOST stringByAppendingFormat:@"/updateAvatar"]

// deprecated...
//获取最新的优惠券
#define api_newestCoupons       [RESTHOST stringByAppendingFormat:@"/newestCoupons"]

//搜索优惠券
#define api_searchCoupons        [RESTHOST stringByAppendingFormat:@"/searchCoupons"]

//获取优惠券
#define api_coupon              [RESTHOST stringByAppendingFormat:@"/coupon"]

//获取区域
#define api_district             [RESTHOST stringByAppendingFormat:@"/district"]
//获取一级区域
#define api_headDistricts        [RESTHOST stringByAppendingFormat:@"/headDistricts"]

//获取快券类型
#define api_couponType           [RESTHOST stringByAppendingFormat:@"/couponType"]
//获取一级类型
#define api_headCouponTypes       [RESTHOST stringByAppendingFormat:@"/headCouponTypes"]


//用户绑定的银行卡
#define api_my_card             [RESTHOST stringByAppendingFormat:@"/mycard"]

//用户下载的快券
#define api_my_downloadedCoupon [RESTHOST stringByAppendingFormat:@"/myDownloadedCoupon"]

//用户收藏的快券
#define api_my_favoritedCoupon  [RESTHOST stringByAppendingFormat:@"/myFavoritedCoupon"]
///因为delete的参数不能用delete传，只有用get，所以要分开api
#define api_my_favoritedCoupon_delete(uid,sessionToken,couponId)  [RESTHOST stringByAppendingFormat:@"/myFavoritedCoupon/uid/%@/sessionToken/%@/couponId/%@",uid,sessionToken,couponId]

//用户收藏的商户(总店)
#define api_my_favoritedShop    [RESTHOST stringByAppendingFormat:@"/myFavoritedShop"]

#define api_my_favoritedShop_delete(uid,sessionToken,shopId)  [RESTHOST stringByAppendingFormat:@"/myFavoritedShop/uid/%@/sessionToken/%@/shopId/%@",uid,sessionToken,shopId]

@interface NetworkClient (){
    
}


@end

@implementation NetworkClient

+ (id)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class]alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _clientManager = [AFHTTPRequestOperationManager manager];
        
        // 必加的
//        _clientManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        _clientManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
        
          }
    return self;
}

#pragma mark -

//第一次把所有的语言都调下来
- (void)queryFirstTimeOpenedWithBlock:(IdResultBlock)block{
    
    
    [self getWithUrl:api_firstTimeOpened parameters:nil block:block];
    
}

- (void)registerWithDict:(NSDictionary*)info block:(IdResultBlock)block{
    
    [self postWithUrl:api_user parameters:info block:block];
    
}

- (void)loginWithUsername:(NSString*)username password:(NSString*)password block:(IdResultBlock)block{


    [self getWithUrl:api_login parameters:@{@"username":username,@"password":password} block:block];
  
    
}

- (void)queryUser:(NSString*)uid block:(IdResultBlock)block{
    
    [self getWithUrl:api_user parameters:@{@"id":uid} block:block];
}

- (void)queryUpdateAvatar:(NSString*)uid image:(UIImage*)image block:(IdResultBlock)block{

    NSData *data = UIImageJPEGRepresentation(image, .8);
    NSString *base64Str = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    
    
    [self postWithUrl:api_updateAvatar parameters:@{@"uid":uid,@"avatar":base64Str} block:block];
}

- (void)queryFirstUpdatedTimeWithBlock:(IdResultBlock)block{

    
    [self getWithUrl:api_updatedTime parameters:nil block:block];
    
}


- (void)queryCoupon:(NSString*)couponId block:(IdResultBlock)block{

//

    [self getWithUrl:api_coupon parameters:@{@"id":couponId} block:block];
}


- (void)queryNewestCouponsSkip:(int)skip block:(IdResultBlock)block{

    
    [self getWithUrl:api_newestCoupons parameters:@{@"skip":[NSString stringWithInt:skip]} block:block];
}


/// deprecated
- (void)queryCouponsWithShop:(NSString*)shopId block:(IdResultBlock)block{
    
    NSString *url = [RESTHOST stringByAppendingFormat:@"/coupon"];
    
//     NSDictionary *params = @{@"where":[AVOSEngine avosPointerWithField:@"shop" className:@"Shop" objectId:shopId]} ;
    
    [self getWithUrl:url parameters:nil block:block];
}




- (void)queryHeadDistrictsWithBlock:(IdResultBlock)block{
    
   
    [self getWithUrl:api_headDistricts parameters:nil block:block];

}

- (void)queryHeadCouponTypesWithBlock:(IdResultBlock)block{

    [self getWithUrl:api_headCouponTypes parameters:nil block:block];
}



///deprecated
- (void)queryShopBranches:(NSString*)parentId block:(IdResultBlock)block{


    NSString *url = [RESTHOST stringByAppendingFormat:@"/shopbranches/parentId/%@",parentId];
    

       [self getWithUrl:url parameters:nil block:block];
}


- (void)searchCoupons:(NSDictionary*)params block:(IdResultBlock)block{

    [self getWithUrl:api_searchCoupons parameters:params block:block];
}

#pragma mark - My

- (void)queryCards:(NSString*)uid block:(IdResultBlock)block{
    
    [self getWithUrl:api_my_card parameters:@{@"uid":uid} block:block];
    
}

- (void)user:(NSString*)uid addCard:(NSString*)cardNumber block:(IdResultBlock)block{

    NSDictionary *params = @{@"uid":uid,@"cardNumber":cardNumber};
    [self postWithUrl:api_my_card parameters:params block:block];
}

- (void)queryDownloadedCoupon:(NSString*)uid block:(IdResultBlock)block{
 
//    NSDictionary *params = @{@"where":[AVOSEngine avosPointerWithField:@"people" className:@"_User" objectId:uid],
//                             @"include":@"coupon"};

    NSDictionary *params = @{@"uid":uid};
    
    [self getWithUrl:api_my_downloadedCoupon parameters:params block:block];
}


- (void)user:(NSString*)uid downloadCoupon:(NSString*)couponId block:(IdResultBlock)block{
    
    
    [self postWithUrl:api_my_downloadedCoupon parameters:@{@"uid":uid,@"couponId":couponId} block:block];
}

- (void)queryFavoritedCoupon:(NSString*)uid block:(IdResultBlock)block{
  
    [self getWithUrl:api_my_favoritedCoupon parameters:@{@"uid":uid} block:block];
}

- (void)user:(NSString*)uid sessionToken:(NSString*)sessionToken favoriteCoupon:(NSString*)couponId block:(IdResultBlock)block{
    
//    NSString *sessionToken = [[UserController sharedInstance] sessionToken];
    
    [self postWithUrl:api_my_favoritedCoupon parameters:@{@"uid":uid,@"couponId":couponId,@"sessionToken":sessionToken} block:block];
    
    
}
- (void)user:(NSString*)uid sessionToken:(NSString*)sessionToken unfavoriteCoupon:(NSString*)couponId block:(IdResultBlock)block{


    [self deleteWithUrl:api_my_favoritedCoupon_delete(uid,sessionToken, couponId) parameters:nil block:block];
    
}


- (void)queryFavoritedShop:(NSString*)uid block:(IdResultBlock)block{
  
    [self getWithUrl:api_my_favoritedShop parameters:@{@"uid":uid} block:block];
    
}


- (void)user:(NSString*)uid sessionToken:(NSString*)sessionToken favoriteShop:(NSString*)shopId block:(IdResultBlock)block{
    
    [self postWithUrl:api_my_favoritedShop parameters:@{@"uid":uid,@"shopId":shopId,@"sessionToken":sessionToken} block:block];
    
}
- (void)user:(NSString*)uid sessionToken:(NSString*)sessionToken unfavoriteShop:(NSString*)shopId block:(IdResultBlock)block{

    
    [self deleteWithUrl:api_my_favoritedShop_delete(uid,sessionToken, shopId) parameters:nil block:block];
    
}

#pragma mark - Intern Fcns


- (void)getWithUrl:(NSString*)url parameters:(NSDictionary*)parameters block:(IdResultBlock)block{
   
//
    
    AFHTTPRequestOperation *operation = [_clientManager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"get url # %@,response : %@ ", url,responseObject);
        
        NSDictionary *dict = responseObject;
        
        if ([dict[@"status"] intValue] == 1) {
            block (dict[@"data"],nil);
        }
        else{
            
            [UIAlertView showAlert:[NSString stringWithFormat:@"错误: %@",[dict[@"status"] description]] msg:dict[@"msg"]];
            block(nil,nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     
        NSLog(@"get url %@,response # %@, error # %@",url, operation.responseString,[error localizedDescription]);
        [UIAlertView showAlertWithError:error];
        block(nil,error);
    }];
    
    
    
    [operation start];
}


/**
 
 post 整个response传给去就好了
 
 */
- (void)postWithUrl:(NSString*)url parameters:(NSDictionary*)parameters block:(IdResultBlock)block{
    
//       NSLog(@"post url # %@",url);
    
    
    AFHTTPRequestOperation *operation = [_clientManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"post url # %@, params # %@,response :%@ %@ ", url,parameters,operation.responseString, responseObject);
        
        
        NSDictionary *dict = responseObject;
        
        if ([dict[@"status"] intValue] == 1) {
            block (dict[@"data"],nil);
        }
        else{
          
            [UIAlertView showAlert:[NSString stringWithFormat:@"错误: %@",[dict[@"status"] description]] msg:dict[@"msg"]];
           
            block(nil,nil);

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"post url # %@,error: %@, %@",url, operation.responseString,[error localizedDescription]);
        [UIAlertView showAlertWithError:error];
        block(nil,error);
    }];
    
    [operation start];
    
}

- (void)putWithUrl:(NSString*)url parameters:(NSDictionary*)parameters block:(IdResultBlock)block{
    
   
    
    
    AFHTTPRequestOperation *operation = [_clientManager PUT:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"put url # %@, response :%@ %@ ",url, operation.responseString, responseObject);
        
        NSDictionary *dict = responseObject;
        
        if ([dict[@"status"] intValue] == 1) {
            block (dict[@"data"],nil);
        }
        else{
            
            [UIAlertView showAlert:[NSString stringWithFormat:@"状态错误: %@",[dict[@"status"] description]] msg:dict[@"msg"]];
            block(nil,nil);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"put url # %@, error: %@, %@",url, operation.responseString,[error localizedDescription]);
        [UIAlertView showAlertWithError:error];
        block(nil,error);
    }];
    
    [operation start];
    
}


- (void)deleteWithUrl:(NSString*)url parameters:(NSDictionary*)parameters block:(IdResultBlock)block{
    
    AFHTTPRequestOperation *operation = [_clientManager DELETE:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"delete url # %@,param # %@,response :%@ %@ ",url,parameters, operation.responseString, responseObject);
        
        NSDictionary *dict = responseObject;
        
        if ([dict[@"status"] intValue] == 1) {
            block (dict[@"data"],nil);
        }
        else{
            
            [UIAlertView showAlert:[NSString stringWithFormat:@"错误: %@",[dict[@"status"] description]] msg:dict[@"msg"]];
            block(nil,nil);
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"delete url # %@,error: %@, %@", url,operation.responseString,[error localizedDescription]);
        [UIAlertView showAlertWithError:error];
        block(nil,error);
    }];
    
    [operation start];
    
}





#pragma mark - Test


- (void)testRegister{
    NSDictionary *params = @{@"username":@"bcss",@"password":@"111",@"phone":@"222",@"nickname":@"bcs"};
    
    [self registerWithDict:params block:^(id object, NSError *error) {
        NSLog(@"obj # %@",object);

    }];
}

- (void)testLogin{

  
    [self loginWithUsername:@"1358965658" password:@"111" block:^(id object, NSError *error) {
        NSLog(@"obj # %@",object);
    }];
    
}


- (void)testUserAddCard{
    [self user:@"539560f2e4b08cd56b62cb98" addCard:@"111222333" block:^(id object, NSError *error) {
        NSLog(@"obj # %@",object);
    }];
}

- (void)testQueryCards{
    [self queryCards:@"539560f2e4b08cd56b62cb98" block:^(id object, NSError *error) {
        NSLog(@"obj # %@",object);
    }];
}


- (void)testUserRest{
 
//    NSString *url = @"http://localhost/kq/index.php/kqapi/user";

      NSString *url = @"http://localhost/kq/index.php/kqapi/user";
    
//    array('objectId'=>array('$in'=>$uids));
    
    NSMutableDictionary *where = [NSMutableDictionary dictionary];
    
    [where setObject:@{@"objectId":@{@"$in":@[@"539676b4e4b09baa2ad7ac78",@"539560f2e4b08cd56b62cb9b"]}} forKey:@"where"];
    
    
//    NSLog(@"where # %@",where);
    [self getWithUrl:url parameters:where block:^(id object, NSError *error) {
//        NSLog(@"user rest obj # %@",object);
        
        
    }];
}


- (void)testSearchCoupon{

    NSDictionary *params = @{@"districtId":@"53956995e4b08cd56b62ec77"};
    
    [self getWithUrl:api_searchCoupons parameters:params block:^(id object, NSError *error) {
        NSLog(@"search obj # %@",object);
    }];
}

- (void)test{
    L();
    
//    [self queryNewestCouponsSkip:0 limit:30 block:^(id object, NSError *error) {
//        NSLog(@"newest coupons # %@",object);
//
//    }];
    
//    [self testSearchCoupon];
    

//    
//    [self queryFirstTimeOpenedWithBlock:^(id object, NSError *error) {
//        NSLog(@"obj # %@",object);
//    }];

    
//    [self getWithUrl:@"http://115.29.148.47/kq/index.php/kqapi3/newestCoupons" parameters:nil block:^(id object, NSError *error) {
//          NSLog(@"obj # %@",object); 
//    }];
    
//    [self queryUpdateAvatar:@"1" image:[UIImage imageNamed:@"ibeacon_museum.jpg"] block:^(NSDictionary *object, NSError *error) {
//        NSLog(@"obj # %@",object);
//    }];
}

@end
