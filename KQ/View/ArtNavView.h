//
//  ArtNavView.h
//  DDX
//
//  Created by Forest on 14-10-14.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Art.h"
#import "AuthorView.h"

@interface ArtNavView : UIScrollView{

    UIImageView *_imgV;
    UITextView * _artDescTV;
    UILabel *_artTitleL;
    
    AuthorView *_authorV;
    UITextView * _authorDescTV;

}


@property (nonatomic, strong) Art *art;


- (void)share;

@end
