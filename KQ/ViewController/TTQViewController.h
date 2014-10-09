//
//  DDXViewController.h
//  DDX
//
//  Created by AppDevelopper on 14-8-30.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVCamViewController.h"

// 首页
@interface TTQViewController : UIViewController


@property (nonatomic, strong) IBOutlet UILabel *titleL;
@property (nonatomic, strong) IBOutlet UIButton *cameraB;
@property (nonatomic, strong) IBOutlet UIButton *guideB;
@property (nonatomic, strong) IBOutlet UIScrollView *mapScrollView;
@property (nonatomic, strong) IBOutlet UIScrollView *guideScrollView;
@property (nonatomic, strong) IBOutlet UIView *footer;

@property (nonatomic, strong) AVCamViewController *avCamVC;

- (IBAction)toggleCamera:(id)sender;
- (IBAction)toggleGuide:(id)sender;

- (void)showMap;
- (void)showGuide;

@end
