//
//  ContainerViewController.m
//  DDX
//
//  Created by Forest on 14-12-8.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "ContainerViewController.h"
#import "NavigationViewController.h"
#import "HallViewController.h"
#import "CameraViewController.h"
#import "TextManager.h"

@interface ContainerViewController ()

@end

@implementation ContainerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _naviMenuVC = [NaviMenuViewController new];
    
    [self load];
    
    
    
    self.shouldAlignStatusBarToPaneView = NO;
    
    // 当语言切换就自动reload
    [[NSNotificationCenter defaultCenter] addObserverForName:NotifiChangeLang object:nil queue:nil usingBlock:^(NSNotification *note) {
       
        [self load];
  
    }];

}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)load{
    
    UIViewController *oldNaviVC = _navigationVC;
    UIViewController *oldHallVC = _hallVC;
    
    _navigationVC = [[NavigationViewController alloc] init];
    
    
    _hallVC = [[HallViewController alloc] init];
    
    
    __weak ContainerViewController *vc = self;
    _hallVC.back = ^{
        [vc toggleSetting];
    };
    _hallVC.togglePane = ^(int index){
        [vc togglePane:index];
    };
    
    _navigationVC.back = ^{
        [vc toggleSetting];
    };
    _navigationVC.togglePane = ^(int index){
        [vc togglePane:index];
    };
    
    
    
    
    [self showNavigation];
    //    [self showHall];
    [self setDrawerViewController:_naviMenuVC forDirection:MSDynamicsDrawerDirectionLeft];
    
    [oldNaviVC.view removeFromSuperview];
    [oldHallVC.view removeFromSuperview];

}

#pragma mark - IBAction


- (IBAction)settingPressed:(id)sender{
    
    [self toggleSetting];
}

#pragma mark - Fcns

- (void)togglePane:(int)index{
    if (index == 0) {
        [self showNavigation];
    }
    else if(index == 1){
        [self showHall];
    }
}

- (void)showNavigation{ // 显示智能导览
    
//    self.title = lang(@"智能导览");
    
    [self setPaneViewController:_navigationVC.nav];
    
}
- (void)showHall{      // 显示手动浏览
    
    [self setPaneViewController:_hallVC.nav];

}



- (void)toggleSetting{
    
    
    if (self.paneState == MSDynamicsDrawerPaneStateOpen) {
        [self closeSetting];
    }
    else{
        [self openSetting];
    }
    
    
}
- (void)openSetting{
    [self setPaneState:MSDynamicsDrawerPaneStateOpen animated:YES allowUserInterruption:NO completion:^{
        
    }];
}

- (void)closeSetting{
    [self setPaneState:MSDynamicsDrawerPaneStateClosed animated:YES allowUserInterruption:NO completion:^{
        
    }];
}

@end
