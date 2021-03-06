//
//  PaneViewController.m
//  DDX
//
//  Created by Forest on 14-12-15.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "PaneViewController.h"
#import "NavigationViewController.h"
#import "HallViewController.h"
#import "CameraViewController.h"
#import "LibraryManager.h"
#import "TTQRootViewController.h"
#import "ArtDetailsViewController.h"

@interface PaneViewController ()

@end

@implementation PaneViewController

- (UINavigationController *)nav{
    
    if (!_nav) {
        _nav = [[UINavigationController alloc] initWithRootViewController:self];
    }
    
    return _nav;
}

- (SINavigationMenuView*)naviMenu{
    
    if (!_naviMenu) {
        CGRect frame = CGRectMake(0.0, 0.0, 200.0, self.navigationController.navigationBar.bounds.size.height);
        SINavigationMenuView *menu = [[SINavigationMenuView alloc] initWithFrame:frame title:_menuArray[0]];
        //        [menu displayMenuInView:self.navigationController.view];
        [menu displayMenuInView:self.view.window];
        menu.items =_menuArray;
        menu.delegate = self;
        _naviMenu = menu;
        
    }
    
    return _naviMenu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _appManager = [AppManager sharedInstance];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    UIImageView *bgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgV.image = [UIImage imageNamed:@"bg.jpg"];
    bgV.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:bgV];
    UIView *maskV = [[UIView alloc] initWithFrame:self.view.bounds];
    maskV.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [self.view addSubview:maskV];
    
    UIBarButtonItem *backBB = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_menu2.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    
    self.navigationItem.leftBarButtonItem = backBB;

    _menuArray = @[lang(@"智能导航"), lang(@"手工导航")];
    
    _closeBtn = [UIButton buttonWithFrame:CGRectMake(_w - 30, 0 ,30, 30) title:nil bgImageName:@"icon_close2.png" target:self action:@selector(closeBtnClicked:)];
    
    _animation = [CATransition animation];
    _animation.duration = 0.3;
    _animation.timingFunction = UIViewAnimationCurveEaseInOut;
    _animation.type = @"rippleEffect";
    _animation.subtype = kCATransitionFromRight;

}


- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    self.navigationItem.titleView = self.naviMenu;  // 不能在viewDidLoad中初始化是因为， 那个时候self.navigationController.view 是nil， 但是否可以设成window
    
}


- (void)dealloc{
//    L();
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NavigationMenuView

- (void)didSelectItemAtIndex:(NSUInteger)index
{
    
    //    NSLog(@"did selected item at index %d", index);
    
    _naviMenu.title = _menuArray[index];
//    NSLog(@"naviMenuButton # %@, title # %@",_naviMenu.menuButton,_naviMenu.menuButton.title);
//    L();
    
    if (index == 1 && [self isKindOfClass:[NavigationViewController class]]) {
        self.togglePane(1);
    }
    else if(index == 0 && [self isKindOfClass:[HallViewController class]]){
        self.togglePane(0);
    }

    
}

#pragma mark - IBAction
- (IBAction)back:(id)sender{
    L();
    
    if (_naviMenu.menuButton.isActive) { //
        return;
    }
   self.back();
}

- (IBAction)closeBtnClicked:(id)sender{
    
    [_closeBtn removeFromSuperview];
    
    [self closeArt];
}

- (IBAction)sharePressed:(id)sender{
    L();
}
#pragma mark - Fcns

- (void)pushCamera{
    
    if (!_cameraVC) {
        _cameraVC = [CameraViewController new];
    }
    
    [self.navigationController pushViewController:_cameraVC animated:YES];
    
}

- (void)showArt:(Art*)art{
    
}

- (void)closeArt{
    
    
    [_artVC.view removeFromSuperview];
    [[self.view layer] addAnimation:_animation forKey:@"animation"];
    
}


- (void)likeArt:(Art*)art{
    L();
}
- (void)shareArt:(Art*)art{
    L();
    [_appManager shareArt:art];

}

@end
