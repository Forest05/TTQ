//
//  NavigationArtViewController.h
//  DDX
//
//  Created by Forest on 14-12-10.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ArtDetailsViewController.h"

@interface NavigationArtViewController : ArtDetailsViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIImageView *bannerV;
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) UITextView *textV;
@property (nonatomic, strong) UILabel *titleL;

@end
