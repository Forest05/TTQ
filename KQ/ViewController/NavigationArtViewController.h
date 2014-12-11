//
//  NavigationArtViewController.h
//  DDX
//
//  Created by Forest on 14-12-10.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Art.h"

@interface NavigationArtViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) Art *art;
@property (nonatomic, strong) UIImageView *bannerV;
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) UITextView *textV;
@end