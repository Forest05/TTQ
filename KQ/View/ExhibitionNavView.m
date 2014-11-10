//
//  ExhibitionNavView.m
//  DDX
//
//  Created by Forest on 14-10-17.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ExhibitionNavView.h"
#import "LibraryManager.h"
#import "UIImageView+WebCache.h"
#import "TTQRootViewController.h"
@implementation ExhibitionNavView


- (void)setExhibition:(Exhibition *)art{
    //    NSLog(@"art # %@",art);
    
    _exhibition = art;
    
    [_imgV setImageWithURL:[NSURL URLWithString:art.imgUrl] placeholderImage:nil];
    if (isZH) {
        _artTitleL.text = art.name;
        _artDescTV.text = art.desc;
        _authorV.author = art.curator;
        _authorDescTV.text = art.curator.desc;
        
    }
    else{
        _artTitleL.text = art.name_en;
        _artDescTV.text = art.description_en;
        _authorV.author = art.curator;
        _authorDescTV.text = art.curator.description_en;
        
    }
    
}


- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        CGFloat width = frame.size.width;
        
        _imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 0.6 * width)];
        _imgV.contentMode = UIViewContentModeScaleAspectFill;
        _imgV.layer.masksToBounds = YES;
        
        _artDescTV = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_imgV.frame)+10, width - 20, 100)];
        _artDescTV.backgroundColor = kColorGreen;
        _artDescTV.textColor = [UIColor whiteColor];
        _artDescTV.editable = NO;
        _artDescTV.selectable = NO;
        
        _artTitleL = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imgV.frame)-40, width, 40)];
        _artTitleL.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        _artTitleL.textAlignment = NSTextAlignmentCenter;
        _artTitleL.font = [UIFont fontWithName:kFontBoldName size:12];
        
        
        _authorV = [[AuthorView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_artDescTV.frame)+10,width, 50)];
        
        _authorDescTV = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_authorV.frame), width - 20, 90)];
        _authorDescTV.backgroundColor = kColorGreen;
        _authorDescTV.textColor = [UIColor whiteColor];
        _authorDescTV.selectable = NO;
        _authorDescTV.editable = NO;
        
        //        UIButton *closeBtn = [UIButton buttonWithFrame:CGRectMake(width - 40, 10, 30, 30) title:nil bgImageName:@"icon_mysettings.png" target:self action:@selector(closeClicked:)];
        
        
//        UIButton *shareBtn = [UIButton buttonWithFrame:CGRectMake(10, CGRectGetMaxY(_imgV.frame) - 40, 30, 30) title:nil bgImageName:@"分享icon.png" target:self action:@selector(shareClicked:)];
        //        shareBtn.backgroundColor = [UIColor redColor];
        
        [self addSubview:_imgV];
        [self addSubview:_artTitleL];
        [self addSubview:_artDescTV];
        [self addSubview:_authorV];
        [self addSubview:_authorDescTV];
//        [self addSubview:closeBtn];
//        [self addSubview:shareBtn];
        
        self.contentSize = CGSizeMake(0, CGRectGetMaxY(_authorDescTV.frame)+ 10);
        
        self.backgroundColor = kColorBG;
        
        
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 5;
    }
    
    return self;
}

#pragma mark - IBAction

//- (IBAction)closeClicked:(id)sender{
//
//    self.closeBlock();
//
//}

- (IBAction)shareClicked:(id)sender{
    [self share];
}

#pragma mark - Fcns
- (void)share{
    
    [[LibraryManager sharedInstance] shareWithText:@"bbb" image:[UIImage imageNamed:@"avatar.jpg"] delegate:[TTQRootViewController sharedInstance]];
    
}

@end
