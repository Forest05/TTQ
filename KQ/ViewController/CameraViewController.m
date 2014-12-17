//
//  CameraViewController.m
//  DDX
//
//  Created by Forest on 14-12-8.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "CameraViewController.h"
#import "LibraryManager.h"
#import "TextManager.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = lang(@"拍摄照片");
    
    [self registerNotifications];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
    
    _bgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _bgV.contentMode = UIViewContentModeScaleAspectFill;
    
    UIColor *color = [UIColor colorWithWhite:0 alpha:.4];
    _cameraBtn = [UIButton buttonWithFrame:CGRectMake(0, 160, 150, 50) title:lang(@"重拍") bgImageName:nil target:self action:@selector(buttonClicked:)];
    _cameraBtn.backgroundColor = color;
    [_cameraBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_cameraBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    _shareBtn = [UIButton buttonWithFrame:CGRectMake(0, 240, 150, 50) title:lang(@"分享") bgImageName:nil target:self action:@selector(buttonClicked:)];
    _shareBtn.backgroundColor = color;
    [_shareBtn setTitleColor:kColorYellow forState:UIControlStateNormal];
    [_shareBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    

    [self.navigationController.navigationBar setTranslucent:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self openCamera];
    
}
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    [_camVC stopSesseion];
  
}

- (void)registerNotifications{

    __weak CameraViewController *vc = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:@"takePhoto" object:nil queue:nil usingBlock:^(NSNotification *note) {
        
        vc.image = note.object;
        
        [vc closeCamera];

    }];
}
- (void)dealloc{
    
    L();
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - IBAction
- (IBAction)handleTap:(id)sender{
    L();
  #if TARGET_IPHONE_SIMULATOR
    [[NSNotificationCenter defaultCenter] postNotificationName:@"takePhoto" object:DefaultImg];
#else
    //    [NSThread sleepForTimeInterval:3];
    [_camVC captureStillImage:nil];
#endif


}

- (IBAction)buttonClicked:(id)sender{
 
    if (sender == _cameraBtn) {
        [self openCamera];
    }
    else if(sender == _shareBtn){
        [self shareImage:_image];
    }
}

#pragma mark - Fcns

- (void)openCamera{

    if (!_camVC) {
        _camVC = [[AVCamViewController alloc] initWithNibName:@"AVCamViewController" bundle:nil];
    }
    
    [self.view addSubview:_camVC.view];
    
    [_camVC startSesseion];
    
    
    self.isCameraOn = YES;

    [_shareBtn removeFromSuperview];
    [_cameraBtn removeFromSuperview];
}

// 显示2个按钮
- (void)closeCamera{
    
    [_camVC stopSesseion];
    
    [self.view addSubview:_shareBtn];
    [self.view addSubview:_cameraBtn];
}

- (void)shareImage:(UIImage*)image{
    
    LibraryManager *mng = [LibraryManager sharedInstance];
    
    [mng shareWithText:@"分享" image:image delegate:self];
}


@end
