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

@implementation ArtNavView

- (void)setArt:(Art *)art{
//    NSLog(@"art # %@",art);
    
    _art = art;
    
    [_imgV setImageWithURL:[NSURL URLWithString:art.imgUrl] placeholderImage:nil];
    _artDescTV.text = art.desc;
    _authorV.author = art.author;
    _authorDescTV.text = art.author.desc;
    

}

- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        CGFloat width = frame.size.width;

        _imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 0.6 * width)];
        
        _artDescTV = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_imgV.frame)+10, width - 20, 100)];
        _artDescTV.backgroundColor = kColorGreen;
        _artDescTV.textColor = [UIColor whiteColor];
        
        _artTitleL = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imgV.frame)-40, width, 40)];
        _artTitleL.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        
        
        _authorV = [[AuthorView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_artDescTV.frame)+10,width, 50)];
        
        _authorDescTV = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_authorV.frame), width - 20, 100)];
        _authorDescTV.backgroundColor = kColorGreen;
        _artDescTV.textColor = [UIColor whiteColor];
        
        UIButton *closeBtn = [UIButton buttonWithFrame:CGRectMake(10, 10, 30, 30) title:nil bgImageName:@"icon_mysettings.png" target:self action:@selector(closeClicked:)];
        
        UIButton *shareBtn = [UIButton buttonWithFrame:CGRectMake(10, width, 30, 30) title:nil bgImageName:@"icon_password.png" target:self action:@selector(shareClicked:)];
        
        [self addSubview:_imgV];
        [self addSubview:_artTitleL];
        [self addSubview:_artDescTV];
        [self addSubview:_authorV];
        [self addSubview:_authorDescTV];
        [self addSubview:closeBtn];
        [self addSubview:shareBtn];
        
        self.contentSize = CGSizeMake(0, CGRectGetMaxY(_authorDescTV.frame)+ 10);
        
        self.backgroundColor = kColorGreen;
        
       
    }
    
    return self;
}

#pragma mark - IBAction

- (IBAction)closeClicked:(id)sender{

    self.closeBlock();
    
}

- (IBAction)shareClicked:(id)sender{
    [self share];
}

#pragma mark - Fcns
- (void)share{

    [[LibraryManager sharedInstance] shareWithText:@"bbb" image:[UIImage imageNamed:@"avatar.jpg"] delegate:[TTQRootViewController sharedInstance]];
    
}

@end
