//
//  CameraViewController.h
//  DDX
//
//  Created by Forest on 14-12-8.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVCamViewController.h"

@interface CameraViewController : UIViewController<UIAlertViewDelegate>{
  
    AVCamViewController *_camVC;
    UIImageView *_bgV;
    
}

@property (nonatomic, assign) BOOL isCameraOn;
@property (nonatomic, strong) UIImageView *bgV;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIButton *cameraBtn, *shareBtn;

@property (nonatomic, strong) AVCamViewController *camVC;

- (void)openCamera;
- (void)closeCamera;
- (void)shareImage:(UIImage*)image;

@end
