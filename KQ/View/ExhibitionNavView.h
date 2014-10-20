//
//  ExhibitionNavView.h
//  DDX
//
//  Created by Forest on 14-10-17.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Exhibition.h"
#import "AuthorView.h"
@interface ExhibitionNavView : UIScrollView{
    
    UIImageView *_imgV;
    UITextView * _artDescTV;
    UILabel *_artTitleL;
    
    AuthorView *_authorV;
    UITextView * _authorDescTV;
}


@property (nonatomic, strong) Exhibition *exhibition;
@end
