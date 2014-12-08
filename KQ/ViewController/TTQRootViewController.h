//
//  KQRootViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-5-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "RootViewController.h"
#import "MSDynamicsDrawerViewController.h"

@class KQLoginViewController;

@class ContainerViewController;



// 作为TTQ的容器
@interface TTQRootViewController : RootViewController<UITabBarControllerDelegate>{


    ContainerViewController *_containerVC;
    UINavigationController *_nav;

    MSDynamicsDrawerViewController *dynamicsDrawerViewController;
}

//@property (nonatomic, strong) ChooseLangViewController *chooseLangVC;
//@property (nonatomic, strong) HallEntranceViewController *hallEntranceVC;
//@property (nonatomic, strong) UINavigationController *hallEntranceNav;
@property (nonatomic, strong) UINavigationController *loginNav;


//- (void)toChooseLang;
//- (void)toHallEntrance;
//
//
//- (void)toLogin;
//
//- (void)didLogin;
//- (void)didLogout;



- (void)didChangeLanguage;


@end
