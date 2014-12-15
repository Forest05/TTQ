//
//  ArtDetailsViewController.h
//  DDX
//
//  Created by Forest on 14-12-15.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "Art.h"

@interface ArtDetailsViewController : UIViewController{
    UIImageView *_artImgV;
    UILabel *_artTitleL;
    UITextView *_artDescTV;
    
    Art *_art;
}


@property (nonatomic, strong) Art *art;

@end
