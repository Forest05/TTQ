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
    
    _naviMenuVC = [NaviMenuViewController new];
    
    UIBarButtonItem *settingBB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(settingPressed:)];
    self.navigationItem.leftBarButtonItem = settingBB;
    
    UIBarButtonItem *cameraBB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(cameraPressed:)];
    self.navigationItem.rightBarButtonItem = cameraBB;


    self.shouldAlignStatusBarToPaneView = NO;
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
  
  
    [self setPaneViewController:_hallVC.nav];
    [self setDrawerViewController:_naviMenuVC forDirection:MSDynamicsDrawerDirectionLeft];
//

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - IBAction
- (IBAction)cameraPressed:(id)sender{
    
    [self pushCamera];
    
}

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


- (void)pushCamera{
    
    if (!_cameraVC) {
        _cameraVC = [CameraViewController new];
    }
    
    [self.navigationController pushViewController:_cameraVC animated:YES];
    
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
