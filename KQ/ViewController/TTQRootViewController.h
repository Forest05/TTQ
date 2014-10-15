//
//  KQRootViewController.h
//  KQ
//
//  Created by AppDevelopper on 14-5-22.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "RootViewController.h"
#import "TTQViewController.h"

@class ChooseLangViewController;
@class HallEntranceViewController;
@class HallViewController;
@class KQLoginViewController;


@interface TTQRootViewController : RootViewController<UITabBarControllerDelegate>{

    TTQViewController *_baseVC;

}

@property (nonatomic, strong) ChooseLangViewController *chooseLangVC;
@property (nonatomic, strong) HallEntranceViewController *hallEntranceVC;
@property (nonatomic, strong) UINavigationController *hallEntranceNav;
@property (nonatomic, strong) UINavigationController *loginNav;

- (void)toChooseLang;
- (void)toHallEntrance;
- (void)toHall;

- (void)toLogin;

- (void)didLogin;
- (void)didLogout;

- (void)didChangeLanguage;


@end
