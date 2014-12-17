//
//  PaneViewController.h
//  DDX
//
//  Created by Forest on 14-12-15.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppManager.h"

#import "ArtDetailsViewController.h"
#import "SINavigationMenuView.h"
#import "TextManager.h"

@class CameraViewController;

@interface PaneViewController : UIViewController<SINavigationMenuDelegate>{

    
    UITableView *_tableView;
    
    
    AppManager *_appManager;
    ArtDetailsViewController *_artVC;
    
    UINavigationController *_nav;
    
    SINavigationMenuView *_naviMenu;            // 导航栏上的menu条
    
     CameraViewController *_cameraVC;
  
    CATransition *_animation;
    UIButton *_closeBtn;
    NSArray *_menuArray;
}

@property (nonatomic, strong) SINavigationMenuView *naviMenu;

@property (nonatomic, copy) void(^back)(void);
@property (nonatomic, copy) void(^togglePane)(int);
@property (nonatomic, strong) UINavigationController *nav;

- (IBAction)closeBtnClicked:(id)sender;

- (void)pushCamera;

- (void)showArt:(Art*)art;
- (void)closeArt;

- (void)likeArt:(Art*)art;
- (void)shareArt:(Art*)art;
@end
