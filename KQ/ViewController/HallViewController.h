//
//  HallViewController.h
//  DDX
//
//  Created by Forest on 14-10-5.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArtNavView.h"
#import "AppManager.h"

@interface HallViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{

    UITableView *_tableView;

    ArtNavView *_artView;
    
    AppManager *_appManager;
    
    NSArray *_arts;

}

@property (nonatomic, strong) NSArray *arts;

- (void)showArt:(Art*)art;
- (void)closeArt;

@end
