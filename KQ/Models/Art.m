//
//  Art.m
//  DDX
//
//  Created by Forest on 14-9-26.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "Art.h"

@implementation Art

/**
 "id": "8",
 "exhibitionId": "1",
 "authorId": "3",
 "serialNumber": "9",
 "name": "Vicki 声音装置",
 "name_en": "Vicking Ling",
 "description": "这是一场图像和空间的对话。凌小童以其细腻感性的作品风格，试图通过最简单质朴的材质和媒介来探究空间和绘画的多维关系。通过对自然的观察和个人生活的体验，将惯常的元素重新打散和重组，在有序和无序之间建立起带有强烈个人风格的视觉图像。",
 "description_en": "This is a dialogue between images and space. Through her delicate emotional, Vicki Ling try to explore the relationship between space and multi-dimensional painting through the most simple original materials and medium. The usual elements re-broken and restructuring in her sensitive observation and experience of natural personal life. It is about to establish artist’s a strong personal style with visual images between order and disorder.",
 "imgUrl": "http://115.29.148.47/ttq/public/images/arts/art_9.jpg",
 "minor": "3",
 
 "aname": "凌小童",
 "aname_en": "Vicking Ling",
 "adescription": "凌小童是一位旅英艺术家，毕业于中央圣马丁艺术设计学院。2014年在柏林举办个人作品展‘Rear Window’。善于铅笔画,她对细节有极强的洞察力,能够通过自己虚构的幻想传递出与众不同的情绪体验。已在欧洲多次举办过展览，并且出版作品。",
 "adescription_en": "Vicki Ling is an artist in Britain who graduated from Central Saint Martin Collage of Art and Design. In 2014, she held personal exhibition Rear Window in Berlin. Good at pencil painting and sensitive to details, Vicki is able to deliver special emotional feelings through her own fictional fantasy. She has held exhibitions and published works many times in Europe. ",
 "avatarUrl": "http://115.29.148.47/ttq/public/images/arts/art_7.jpg"
 */


static NSArray *keys;

- (id)initWithDict:(NSDictionary *)dict{
    
    if (self = [self init]) {
        
        self.dict = dict;
        
        if (!keys) {
            
            keys = @[@"id",@"exhibitionId",@"authorId",@"name",@"name_en",@"description_en",@"imgUrl",@"minor",@"serialNumber",@"like"];
        
        }
        
        for (NSString *key in keys) {
            [self setValue:dict[key] forKey:key];
        }
        self.desc = dict[@"description"];

        NSDictionary *authorDict = @{@"id":self.authorId,@"name":dict[@"aname"],@"name_en":dict[@"aname_en"],@"description":dict[@"adescription"],@"description_en":dict[@"adescription_en"],@"avatarUrl":dict[@"avatarUrl"]};
        self.author = [[Author alloc] initWithDict:authorDict];

//        NSLog(@"author # %@",self.author.name);
        
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    Art *art = [[Art alloc] initWithDict:self.dict];
    
    return art;
}

- (void)configBeaconWithUUID:(NSUUID*)uuid major:(int)major{

    if (!ISEMPTY(self.minor)) {
        self.beacon = [[TTQBeacon alloc] init];
        self.beacon.uuid = uuid;
        self.beacon.majorValue = major;
        self.beacon.minorValue = [self.minor integerValue];
        
    }
}



- (void)display{
    
    NSLog(@"--------------Begin Display %@ # %@------------\n",NSStringFromClass(self.class),self);
    for (NSString *key in keys) {
        NSLog(@"%@ => %@",key, [self valueForKey:key]);
    }
    
    NSLog(@"desc => %@",self.desc);
    NSLog(@"--------------End Display----------------");
}

@end
