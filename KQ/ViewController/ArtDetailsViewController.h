//
//  ArtDetailsViewController.h
//  DDX
//
//  Created by Forest on 14-12-15.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppManager.h"
#import "Art.h"
#import "PaneViewController.h"

@interface ArtDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UIImageView *_artImgV;
    UILabel *_artTitleL;
    UITextView *_artDescTV;
    UITableView *_tableView;
    
    Art *_art;
    
    AppManager *_manager;
    
    __unsafe_unretained PaneViewController *_parent;
}

@property (nonatomic ,unsafe_unretained) PaneViewController *parent;
@property (nonatomic, strong) Art *art;
@property (nonatomic, strong) Hall *hall;
@property (nonatomic, strong) UITableView *tableView;

@end
