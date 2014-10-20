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
//        NSLog(@"art # %@",art.name);
    
    
    _art = art;

    [_artImgV setImageWithURL:[NSURL URLWithString:art.imgUrl]];

    
    _artL.text = isZH?art.name:art.name_en;

    
}

// 150x150

- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {

        CGFloat width = frame.size.width;
        
        _artImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 0.66*width)];
        _artImgV.contentMode = UIViewContentModeScaleAspectFill;
        _artImgV.layer.masksToBounds= YES;
        
        _artL = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_artImgV.frame), width, 50)];
        _artL.backgroundColor = kColorGreen;
//        _artL.textColor = [UIColor colorWithRed:130.0/255 green:130.0/255 blue:130.0/255 alpha:1];
        _artL.textColor = [UIColor whiteColor];
        _artL.font = [UIFont fontWithName:kFontName size:10];
        _artL.textAlignment = NSTextAlignmentCenter;
        _artL.numberOfLines = 0;
        
        
//        _authorImgV = [[UIImageView alloc] initWithFrame:CGRectMake(width/2 - 30, CGRectGetMaxY(_artImgV.frame)-30, 60, 60)];
        
        [self addSubview:_artImgV];
        [self addSubview:_artL];

        UIButton *likeB = [UIButton buttonWithFrame:CGRectMake(10, 120, 30, 30) title:@"like" bgImageName:nil target:self action:@selector(buttonClicked:)];
        likeB.backgroundColor = [UIColor redColor];
//        [self addSubview:likeB];
        
//        self.layer.borderWidth = 1;
//        self.layer.borderColor = [UIColor darkGrayColor].CGColor;
    }
    
    return self;
}

#pragma mark - IBAction
- (IBAction)buttonClicked:(id)sender{
    L();
}


@end
