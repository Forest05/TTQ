//
//  CameraViewController.m
//  DDX
//
//  Created by Forest on 14-12-8.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "CameraViewController.h"
#import "TextManager.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = lang(@"拍摄照片");
    
    _bgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _bgV.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
    
    
    
    
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
    
//    [self openCamera];
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    [_camVC stopSesseion];
}

- (void)registerNotifications{

    __weak CameraViewController *vc = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:@"takePhoto" object:nil queue:nil usingBlock:^(NSNotification *note) {
        
        vc.image = note.object;
        
//        vc.bgV.image = img;
//        [vc.camVC.view removeFromSuperview];
    }];
}
- (void)dealloc{
    
    L();
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - IBAction
- (IBAction)handleTap:(id)sender{
    L();
    [_camVC captureStillImage:nil];
}


#pragma mark - Fcns

- (void)openCamera{

    if (!_camVC) {
        _camVC = [[AVCamViewController alloc] initWithNibName:@"AVCamViewController" bundle:nil];
    }
    
    [self.view addSubview:_camVC.view];
    
    [_camVC startSesseion];
    
    
    self.isCameraOn = YES;
}

@end
