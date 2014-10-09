//
//  DDXViewController.m
//  DDX
//
//  Created by AppDevelopper on 14-8-30.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import "TTQViewController.h"
#import "LibraryManager.h"
#import "TTQRootViewController.h"


@interface TTQViewController ()

@end

@implementation TTQViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    CGFloat height = self.view.height;

    
    
    _mapScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, 320, height - 120)];
    UIImageView *mapV = [[UIImageView alloc] initWithFrame:CGRectMake(32, 0, 255, 380)];
    mapV.image = [UIImage imageNamed:@"室内地图.png"];
    [_mapScrollView addSubview:mapV];
    
    
    _guideScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, 320, height - 120)];
    UIImageView *imgV1 = [[UIImageView alloc]initWithFrame:CGRectMake(35, 0, 250, 372)];
    imgV1.image = [UIImage imageNamed:@"2_1.png"];
    imgV1.userInteractionEnabled = YES;
    [imgV1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(share:)]];
    
    UIImageView *imgV2 = [[UIImageView alloc]initWithFrame:CGRectMake(35, CGRectGetMaxY(imgV1.frame), 250, 72)];
    imgV2.image = [UIImage imageNamed:@"2_2.png"];
    
    UIImageView *imgV3 = [[UIImageView alloc]initWithFrame:CGRectMake(35, CGRectGetMaxY(imgV2.frame), 250, 376)];
    imgV3.image = [UIImage imageNamed:@"3_2.png"];
    
    [_guideScrollView addSubview:imgV1];
    [_guideScrollView addSubview:imgV2];
    [_guideScrollView addSubview:imgV3];
    
    [_guideScrollView setContentSize:CGSizeMake(0, CGRectGetMaxY(imgV3.frame))];
    
    
    _avCamVC = [[AVCamViewController alloc]initWithNibName:@"AVCamViewController" bundle:nil];
    
    [self showMap];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    CGFloat height = self.view.height;
    
    
    [self.footer setOrigin:CGPointMake(0, height-self.footer.height)];
    
    L();
    
    NSLog(@"root # %@",[TTQRootViewController sharedInstance]);
    
    
//    NSLog(@"height # %f,subviews # %@",height,self.view.subviews);
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)toggleCamera:(id)sender{

    if (_avCamVC.view.superview) {
        [_avCamVC.view removeFromSuperview];
    }
    else{
        [self.view addSubview:_avCamVC.view];
    }
    
}
- (IBAction)toggleGuide:(id)sender{

    if (_mapScrollView.superview) {
        
        [self showGuide];
        
    }
    else{
        [self showMap];
    }
    
}

- (void)showMap{
    _titleL.text = @"室内导航";
    
    [_guideScrollView removeFromSuperview];
    [self.view addSubview:_mapScrollView];
    
}
- (void)showGuide{
    _titleL.text = @"作品讲解";
    
    [_mapScrollView removeFromSuperview];
    [self.view addSubview:_guideScrollView];
    
}

- (void)share:(UITapGestureRecognizer*)tap{

    L();
    
    [[LibraryManager sharedInstance] shareWithText:nil image:nil delegate:self];
}


@end
