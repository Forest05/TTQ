//
//  NavigationViewController.h
//  DDX
//
//  Created by Forest on 14-10-5.
//  Copyright (c) 2014年 Xappsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NavigationArtViewController;

#import "AVCamViewController.h"
#import "AppManager.h"
#import "ArtNavView.h"
#import "ExhibitionNavView.h"

@interface NavigationViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>{

    AVCamViewController *_camVC;
    ArtNavView *_artView;
//    ExhibitionNavView *_exhibitionView;
    NavigationArtViewController *_artVC;
    
    UIScrollView *_scrollView;
    UITextField *_tf;
    UIBarButtonItem *_cameraBB;
    
    UILabel *_label;
    UITableView *_tv;

    NSArray *_tableKeys;
    
    AppManager *_appManager;
    
    
}

@property (nonatomic, assign) BOOL isCameraOn;
@property (nonatomic, assign) BOOL isArtViewOn;
@property (nonatomic, strong) Art *selectedArt;
@property (nonatomic, strong) Art *showedArt;


//- (void)openCamera;
//- (void)closeCamera;


- (void)showArt:(Art*)art;
- (void)closeArt;



@end
