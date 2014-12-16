//
//  ContainerViewController.h
//  DDX
//
//  Created by Forest on 14-12-8.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MSDynamicsDrawerViewController.h"
#import "NaviMenuViewController.h"

@class HallViewController;
@class NavigationViewController;



@interface ContainerViewController : MSDynamicsDrawerViewController{
    
    NavigationViewController *_navigationVC;    // 智能导览
    HallViewController *_hallVC;                // 手动浏览
   
    NaviMenuViewController *_naviMenuVC;
    
}



- (void)showNavigation; // 显示智能导览
- (void)showHall;       // 显示手动浏览

- (void)toggleSetting;
- (void)openSetting;
- (void)closeSetting;
- (void)togglePane:(int)index;
@end
