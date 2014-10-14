//
//  ArtListView.h
//  DDX
//
//  Created by Forest on 14-10-14.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Art.h"
@interface ArtListView : UIView{

    
    UIImageView *_artImgV;
    UIImageView *_authorImgV;
    UILabel *_artL;
    
    
}

@property (nonatomic, strong) Art *art;

@end
