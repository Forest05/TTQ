//
//  ArtListView.m
//  DDX
//
//  Created by Forest on 14-10-14.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ArtListView.h"
#import "UIImageView+WebCache.h"

@implementation ArtListView


- (void)setArt:(Art *)art{
    //    NSLog(@"art # %@",art);
    
    
    _art = art;
    _artImgV.image = [UIImage imageNamed:@"avatar.jpg"];
    _artL.text = art.name;
    _authorImgV.image = [UIImage imageNamed:@"avatar.jpg"];
    
}

// 150x230

- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {

        CGFloat width = frame.size.width;
        
        _artImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
        
        _artL = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_artImgV.frame), width, 50)];
        
        _authorImgV = [[UIImageView alloc] initWithFrame:CGRectMake(width/2 - 30, CGRectGetMaxY(_artImgV.frame)-30, 60, 60)];
        
        [self addSubview:_artImgV];
        [self addSubview:_artL];
        [self addSubview:_authorImgV];
        
        self.backgroundColor = [UIColor redColor];
        
        
    }
    
    return self;
}


@end
