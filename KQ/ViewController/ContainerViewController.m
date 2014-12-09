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

- (SINavigationMenuView*)naviMenu{
    
    if (!_naviMenu) {
         CGRect frame = CGRectMake(0.0, 0.0, 200.0, self.navigationController.navigationBar.bounds.size.height);
        SINavigationMenuView *menu = [[SINavigationMenuView alloc] initWithFrame:frame title:_menuArray[0]];
//        [menu displayMenuInView:self.navigationController.view];
         [menu displayMenuInView:self.view.window];
        menu.items =_menuArray;
        menu.delegate = self;
//        self.navigationItem.titleView = menu;
        _naviMenu = menu;

    }
    
    return _naviMenu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationController.navigationBar.alpha = 0.1;
    
    _navigationVC = [[NavigationViewController alloc] init];
    
    _hallVC = [[HallViewController alloc] init];
    
    _menuArray = @[lang(@"智能导航"), lang(@"手工导航")];
    
  
    UIBarButtonItem *settingBB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(settingPressed:)];
    self.navigationItem.leftBarButtonItem = settingBB;
    
    UIBarButtonItem *cameraBB = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(cameraPressed:)];
    self.navigationItem.rightBarButtonItem = cameraBB;



    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    self.navigationItem.titleView = self.naviMenu;  // 不能在viewDidLoad中初始化是因为， 那个时候self.navigationController.view 是nil， 但是否可以设成window
    
    
    [self setPaneViewController:[NavigationViewController new]];
    [self setDrawerViewController:[CameraViewController new] forDirection:MSDynamicsDrawerDirectionLeft];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NavigationMenuView

- (void)didSelectItemAtIndex:(NSUInteger)index
{
    NSLog(@"did selected item at index %d", index);
    _naviMenu.title = _menuArray[index];
    
    if (index == 0) {
        [self showNavigation];
    }
    else{
        [self showHall];
    }
    
}

#pragma mark - IBAction
- (IBAction)cameraPressed:(id)sender{
    
    [self pushCamera];
    
}

- (IBAction)settingPressed:(id)sender{
    
    [self toggleSetting];
}

#pragma mark - Fcns
- (void)showNavigation{ // 显示智能导览
    
    self.title = lang(@"智能导览");

    
    [self.view addSubview:_navigationVC.view];
    
    
}
- (void)showHall{      // 显示手动浏览
    
    [self.view addSubview:_hallVC.view];
    
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
