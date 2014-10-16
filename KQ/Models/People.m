//
//  People.m
//  KQ
//
//  Created by AppDevelopper on 14-6-2.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "People.h"

@implementation People

- (id)initWithDict:(NSDictionary*)dict{
    if (self = [self init]) {
        
//        NSLog(@"dict # %@",dict);
        
         dict = [dict dictionaryCheckNull];
        self.id = dict[@"id"];
        self.username = dict[@"username"];
        self.phone = dict[@"phone"];
        self.avatarUrl = dict[@"avatarUrl"];
        self.nickname = dict[@"nickname"];
        
        self.favArtIds = [NSMutableArray array];
//        [self.favArtIds addObject:@"s"];
        
        NSArray *favArts = dict[@"favArts"];
        for (NSDictionary *artDict in favArts) {
            [self.favArtIds addObject:artDict[@"artId"]];
        }

        self.avatarStr = dict[@"avatar"];
        if (!ISEMPTY(self.avatarStr)) {
            NSData *data =[[NSData alloc] initWithBase64EncodedString:self.avatarStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
            
           self.avatar = [[UIImage alloc] initWithData:data];

        }
//        NSLog(@"avatarStr # %@",self.avatarStr);
        
        
//        NSLog(@"favArts # %@",self.favArtIds);

        //!!!: 没有用到
//        self.favoritedCouponIds = ISEMPTY(dict[@"favoritedCoupons"])?[NSMutableSet set]:[[NSMutableSet alloc] initWithArray:dict[@"favoritedCoupons"]];
//   
//       
//        ///即使dict没有favoritedShops这个key=>(null)，也能正常初始化！！
//        self.favoritedShopIds = ISEMPTY(dict[@"favoritedShops"])?[NSMutableSet set]:[[NSMutableSet alloc] initWithArray:dict[@"favoritedShops"]];

//        NSLog(@"self.favoritedShopIds # %@",self.favoritedCouponIds);
    }
    return self;
}


+ (id)people{
    
    People *people = [[People alloc] init];
    
    return people;
}


+ (id)peopleWithDict:(NSDictionary*)dict{
    
    return [[People alloc] initWithDict:dict];
}

@end
