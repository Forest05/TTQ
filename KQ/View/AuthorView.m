//
//  AuthorView.m
//  DDX
//
//  Created by Forest on 14-10-14.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "AuthorView.h"

@implementation AuthorView

- (void)setAuthor:(Author *)author{
    _author = author;
    
//    _nameL.text = _author.name;
    _nameL.text = _author.name;
    _avatarV.image = [UIImage imageNamed:@"avatar.jpg"];
}


- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        _nameL = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 40)];
    
        _avatarV = [[UIImageView alloc] initWithFrame:CGRectMake(150, 10, 50, 50)];
        
        [self addSubview:_nameL];
        [self addSubview:_avatarV];
    }
    
    return self;
}
@end
