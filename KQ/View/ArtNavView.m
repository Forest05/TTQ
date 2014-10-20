//
//  ArtNavView.m
//  DDX
//
//  Created by Forest on 14-10-14.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ArtNavView.h"
#import "LibraryManager.h"
#import "UIImageView+WebCache.h"
#import "TTQRootViewController.h"
#import "TextManager.h"


@implementation ArtNavView

- (void)setArt:(Art *)art{
//    NSLog(@"art # %@",art);
    
    _art = art;
    
    [_imgV setImageWithURL:[NSURL URLWithString:art.imgUrl] placeholderImage:nil];
    
    if (isZH) {
        _artTitleL.text = _art.name;
        _artDescTV.text = art.desc;
        _authorV.author = art.author;
        _authorDescTV.text = art.author.desc;

    }
    else{
        
        _artTitleL.text = _art.name_en;
        _artDescTV.text = art.description_en;
        _authorV.author = art.author;
        _authorDescTV.text = art.author.description_en;

    }

}

- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        CGFloat width = frame.size.width;

        _imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 0.6 * width)];
        _imgV.contentMode = UIViewContentModeScaleAspectFill;
        _imgV.layer.masksToBounds = YES;
        
        UILabel *titleV = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imgV.frame)-40, width , 40)];
         titleV.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        
        _artTitleL = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_imgV.frame)-40, width - 40, 40)];
        _artTitleL.textAlignment = NSTextAlignmentCenter;
        _artTitleL.font = [UIFont fontWithName:kFontBoldName size:12];

        
        _artDescTV = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_imgV.frame)+10, width - 20, 100)];
        _artDescTV.backgroundColor = kColorGreen;
        _artDescTV.textColor = [UIColor whiteColor];
        _artDescTV.editable = NO;
        _artDescTV.selectable = NO;
        
//        _artDescTV.font = [UIFont fontWithName:kFontName size:12];
        
        
        _authorV = [[AuthorView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_artDescTV.frame)+10,width, 60)];
        
        _authorDescTV = [[UITextView alloc] initWithFrame:CGRectMake(10,CGRectGetMaxY(_authorV.frame) , width - 20, 100)];
        _authorDescTV.backgroundColor = kColorGreen;
        _authorDescTV.textColor = [UIColor whiteColor];
        _authorDescTV.selectable = NO;
        _authorDescTV.editable = NO;
        
//        UIButton *closeBtn = [UIButton buttonWithFrame:CGRectMake(width - 40, 10, 30, 30) title:nil bgImageName:@"icon_mysettings.png" target:self action:@selector(closeClicked:)];
        
        
        UIButton *shareBtn = [UIButton buttonWithFrame:CGRectMake(width - 40, CGRectGetMaxY(_artDescTV.frame) +10, 30, 30) title:nil bgImageName:@"分享icon.png" target:self action:@selector(shareClicked:)];
//        shareBtn.backgroundColor = [UIColor redColor];
        
        [self addSubview:_imgV];
        [self addSubview:titleV];
        [self addSubview:_artTitleL];
        [self addSubview:_artDescTV];
        [self addSubview:_authorV];
        [self addSubview:_authorDescTV];
        
//        [self addSubview:closeBtn];
        [self addSubview:shareBtn];
        
        self.contentSize = CGSizeMake(0, CGRectGetMaxY(_authorDescTV.frame)+ 10);
        
        self.backgroundColor = kColorBG;
        
       
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 5;
    }
    
    return self;
}

#pragma mark - IBAction


- (IBAction)shareClicked:(id)sender{
    [self share];
}

#pragma mark - Fcns
- (void)share{
    
    NSString *serialNumber = _art.serialNumber;
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"art_%@.jpg",serialNumber]];
    NSString *text = isZH?_art.name:_art.name_en;
    

    [[LibraryManager sharedInstance] shareWithText:[NSString stringWithFormat:@"%@ %@",text,lang(@"喜欢这次的展出《石头、木头和天堂症候群》@1933当代艺术空间")] image:image delegate:[TTQRootViewController sharedInstance]];
    
}

@end
