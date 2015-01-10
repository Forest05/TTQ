//
//  NavigationArtViewController.h
//  DDX
//
//  Created by Forest on 14-12-10.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ArtDetailsViewController.h"

@interface NavigationArtViewController : ArtDetailsViewController{

}

@property (nonatomic, strong) UIImageView *bannerV;


@property (nonatomic, strong) UIScrollView *scrollV;
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *descL;

- (void)shareArt:(Art*)art;

@end
