//
//  HallEntranceViewController.h
//  DDX
//
//  Created by Forest on 14-10-5.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppManager.h"

@interface HallEntranceViewController : UIViewController{

    AppManager *_manager;
    
    UIScrollView *_scrollView;
    UIScrollView *_introduceScrollView;
    UIButton *_toNavigationBtn, *_toHallBtn;
    
}

@property (nonatomic, strong) Hall *hall;

- (void)back;
- (void)toUser;
- (void)toNavigation;
- (void)toHall;

@end
