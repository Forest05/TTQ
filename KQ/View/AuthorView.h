//
//  AuthorView.h
//  DDX
//
//  Created by Forest on 14-10-14.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Author.h"

@interface AuthorView : UIView{
    UILabel *_nameL;
    UIImageView *_avatarV;
}

@property (nonatomic, strong) Author *author;

@end
