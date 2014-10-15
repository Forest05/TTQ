//
//  HallEntranceViewController.h
//  DDX
//
//  Created by Forest on 14-10-5.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppManager.h"

@class NavigationViewController;
@class HallViewController;

@interface HallEntranceViewController : UIViewController<UIScrollViewDelegate>{

    AppManager *_manager;
    
    UIScrollView *_scrollView;
    UIScrollView *_introduceScrollView;
    UIButton *_toNavigationBtn, *_toHallBtn;
    UIPageControl *_pageControl;
    
    NavigationViewController *_navigationVC;
    HallViewController *_hallVC;
    
}

@property (nonatomic, strong) Hall *hall;

- (void)back;
- (void)toUser;
- (void)toNavigation;
- (void)toHall;

@end
