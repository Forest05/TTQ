//
//  Exhibition.m
//  DDX
//
//  Created by Forest on 14-9-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "Exhibition.h"

@implementation Exhibition


/**
 "id": "1",
 "hallId": "1",
 "name": "《石头、木头和天堂症候群》",
 "name_en": " Stone, Wood and Paradise Syndrome",
 "authorId": null,
 "description": "此次名为《石头、木头和天堂症候群》的展览，了当代艺术策展在本土性中，寻找契合彼此震点的共鸣方式下所需的距离，提示了一个展览能呈现这些艺术家全新的方面，对已有名望的艺术家而言，也仍有无限可能性。",
 "description_en": "Looking ...",
 "imgUrl": "http://www.1933shanghai.com/uploads/yanhui/20140415/1397542787.JPG",
 "major": "1",
 "beginDate": null,
 "endDate": null,
 "curatorName": "马雅",
 "curatorName_en": "Maja Ciric",
 "curatorDescription": "马雅是一位在欧洲、中东、亚洲及美国积累了十余年国际策展经验的独立策展人。她对艺术世界的代理商、环境和条件有极为深入的了解，她参与过的许多项目都构建出相当大的全球网络，2012年被伦敦萨奇画廊选为全球百名策展人之一，2007年和2013年担任威尼斯双年展塞尔维亚馆策展人。马雅有着艺术史、艺术理论、策展、文化与性别研究的国际跨学科知识背景，研究领域涉及地缘政治和策展的研究，她的实践逻辑不能被占主导地位的地缘政治结构及其对艺术世界的影响来定义，试图从临界点及后全球化的角度来思考艺术世界。",
 "curatorDescription_en": "Maja Ciric is ...",
 "curatorImgUrl": "http://115.29.148.47/ttq/public/images/curator_maja.jpg"
 **/

static NSArray *keys;

- (id)initWithDict:(NSDictionary *)dict{
    
    if (self = [self init]) {
        if (!keys) {
            keys = @[@"id",@"hallId",@"name",@"name_en",@"description_en",@"imgUrl",@"major",@"beginDate",@"endDate"];
        }
        
        for (NSString *key in keys) {
            [self setValue:dict[key] forKey:key];
        }
        self.desc = dict[@"description"];
        
//        NSLog(@"dict # %@",dict);
        
        NSDictionary *authorDict = @{@"id":@"999",@"name":dict[@"curatorName"],@"name_en":dict[@"curatorName_en"],@"description":dict[@"curatorDescription"],@"description_en":dict[@"curatorDescription_en"],@"avatarUrl":dict[@"curatorImgUrl"]};
        
        self.curator = [[Author alloc] initWithDict:authorDict];

    }
    return self;
}

- (id)init{
    if (self = [super init]) {
      self.artBeacons = [NSMutableDictionary dictionary];
        
        
        
    }
    return self;
}

- (void)display{
    
}
@end
