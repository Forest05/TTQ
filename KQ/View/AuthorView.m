//
//  AuthorView.m
//  DDX
//
//  Created by Forest on 14-10-14.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "AuthorView.h"
#import "TextManager.h"
#import "UIImageView+WebCache.h"

@implementation AuthorView

- (void)setAuthor:(Author *)author{
    _author = author;
    
//    NSString *str= isZH?author.name:author.name_en;
//     _nameL.text
//    _avatarV.image = [UIImage imageNamed:@"avatar.jpg"];

    
    
    
    NSString *title;
    if ([author.name isEqualToString:@"马雅"]) {
        title = lang(@"策展人");
        [_avatarV setImageWithURL:[NSURL URLWithString:author.avatarUrl]];
        _avatarV.hidden = NO;
    }
    else{
        title = lang(@"作者");
        _avatarV.hidden = YES;
    }
    if (isZH) {
        _nameL.text = [NSString stringWithFormat:@"%@: %@",title,author.name];
        
    }
    else{
        _nameL.text = [NSString stringWithFormat:@"%@: %@",title,author.name_en];
    }

}


- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        CGFloat width = frame.size.width;
        
        _nameL = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, width, 40)];
        _nameL.textAlignment = NSTextAlignmentLeft;
        _nameL.textColor = kColorBlack;
    
        _avatarV = [[UIImageView alloc] initWithFrame:CGRectMake(width/2+10, 10, 40, 40)];
        _avatarV.contentMode = UIViewContentModeScaleAspectFit;
        _avatarV.layer.masksToBounds = YES;
        
        [self addSubview:_nameL];
        [self addSubview:_avatarV];
        
        self.backgroundColor = kColorBG;
    }
    
    return self;
}
@end
