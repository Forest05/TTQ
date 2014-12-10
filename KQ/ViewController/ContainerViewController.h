//
//  ContainerViewController.h
//  DDX
//
//  Created by Forest on 14-12-8.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SINavigationMenuView.h"
#import "MSDynamicsDrawerViewController.h"

@class HallViewController;
@class NavigationViewController;
@class CameraViewController;

@interface ContainerViewController : MSDynamicsDrawerViewController<SINavigationMenuDelegate>{
    
    NavigationViewController *_navigationVC;    // 智能导览
    HallViewController *_hallVC;                // 手动浏览
    CameraViewController *_cameraVC;
    
    SINavigationMenuView *_naviMenu;            // 导航栏上的menu条
    
    NSArray *_menuArray;
}

@property (nonatomic, strong) SINavigationMenuView *naviMenu;
//@property (nonatomic, assign) 

- (void)showNavigation; // 显示智能导览
- (void)showHall;       // 显示手动浏览
- (void)pushCamera;
- (void)toggleSetting;
- (void)openSetting;
- (void)closeSetting;
@end
